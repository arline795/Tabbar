require 'csv'

module CommissionFactory
  class ImportProductsService
    attr_reader :commission_factory_category, :user

    def initialize(commission_factory_category)
      @commission_factory_category = commission_factory_category
      @user = commission_factory_category.commission_factory_importer.user
    end

    def call
      ActiveRecord::Base.transaction do
        update_products_crawled_false
        find_or_create_parrent_user_category
        find_or_create_user_category
      end

      products_create_worker
    end

    private

    def update_products_crawled_false
      # Change all the products for this user category to false, because
      # when they're created or updated in ProductCreatorService they're changed to
      # crawled: true. Then all the products that are crawled: false - we can delete them, because
      # they were not updated therefore dont exist anymore.
      category = commission_factory_category.category
      user_category = UserCategory.find_by(user: user, category: category)
      UserCategoryProduct.where(user_category: user_category).each do |ucp|
        product = ucp.product
        product.update(crawled: false) if product.present?
      end
    end

    def find_or_create_parrent_user_category
      UserCategory.find_or_create_by!(
        user: user,
        category: commission_factory_category.category.root
      )
    end

    def find_or_create_user_category
      @user_category = UserCategory.find_or_create_by!(
        user: user,
        category: commission_factory_category.category
      )
    end

    def products_create_worker
      CSV.parse(csv_file, headers: true).each do |row|
        next unless row['Category'].present? && row['Category'].include?(commission_factory_category.query)
        params = row.to_h
        next unless all_params_present(params)

        ProductCreatorWorker.perform_async(
          user.id,
          product_params(params),
          @user_category.id,
          commission_factory_category.id
        )
      end
    end

    def csv_file
      Paperclip.io_adapters.for(
        commission_factory_category.commission_factory_importer.csv
      ).read
    end

    def product_params(params)
      DataClumps::ProductsParams.new(
        params['Name'].force_encoding('utf-8'),
        params['Description'].force_encoding('utf-8'),
        price_in_cents(params['Price']),
        country(params),
        params['Url'],
        [params['Image']]
      ).to_hash
    end

    def all_params_present(params)
      params['Name'].present? &&
        params['Description'].present? &&
        params['Price'].present? &&
        params['Country'].present? &&
        params['Url'].present? &&
        params['Image'].present?
    end

    def country(params)
      params['Country'].present? ? params['Country'] : user.country
    end

    def price_in_cents(price)
      Sanitizers::PriceSanitizer.new(price).dollar_to_price_in_cents
    end
  end
end

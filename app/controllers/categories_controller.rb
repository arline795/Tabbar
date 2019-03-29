class CategoriesController < ApplicationController
  before_action :set_user
  before_action :set_category, only: %i(show products)

  def index
    if params[:parent].to_i.nonzero?
      parent = @user.categories.find(params[:parent])

      @categories = parent.children.presence ||
                    (parent.parent ? parent.parent.children : @user.categories.roots)
    else
      @categories = @user.categories.roots
    end
    @user_categories = @user.user_categories.includes(:category).where(category: @categories)
  end

  def hierachy
    result = []

    if params[:id].to_i.nonzero?
      category = @user.categories.find(params[:id])
      result = category.ancestors.to_a
      result << category if category.children.present?
    end

    render json: [{ id: 0, capitalized_name: 'All' }] + result.map(&:to_sidebar_json)
  end

  def products
    # TODO: products method and hierachy should be put into api. Not here.
    # TODO: needs refractoring
    list = @user.products.joins(user_category_products: :user_category)
                .where(user_categories: { category_id: @category.descendant_ids + [@category.id] })
                .distinct
                .paginate(page: params[:page], per_page: PER_PAGE)

    serialized_list = {}
    serialized_list[:products] = list.map { |product| ProductSerializer.new(product).as_json }
    serialized_list[:has_more] = params[:page].to_i < list.total_pages
    render json: serialized_list, status: :ok
  end

  private

  def set_user
    @user = User.friendly.find(params[:username])
  end

  def set_category
    @category = @user.categories.find(params[:id])
  end
end

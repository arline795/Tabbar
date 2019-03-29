class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :user_category_products, dependent: :destroy
  has_many :products, through: :user_category_products

  def products_count
    UserCategoryProduct.where(user_category: category.contained_user_categories(user)).count
  end

  def products
    user_categorie_ids = UserCategory.where(user: user, category: category).map(&:id)
    Product.where(id: UserCategoryProduct.includes(:user_category)
                                         .where(user_category_id: user_categorie_ids)
                                         .pluck(:product_id))
  end
end

class UserCategoryProduct < ApplicationRecord
  belongs_to :user_category
  belongs_to :product
end

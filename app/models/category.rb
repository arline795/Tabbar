class Category < ApplicationRecord
  has_ancestry
  has_many :user_categories, dependent: :destroy

  validates :name, presence: true

  class << self
    def user_has_men?(user)
      user.categories.find_by(name: 'men').present?
    end

    def user_has_women?(user)
      user.categories.find_by(name: 'women').present?
    end
  end

  def contained_user_categories(user)
    UserCategory.where(category_id: [id] + descendant_ids, user: user)
  end

  def to_option
    [hierachy_name, id]
  end

  def to_sidebar_json
    {
      id: id,
      capitalized_name: capitalized_name
    }
  end

  def hierachy_name
    (ancestors + [self]).map(&:capitalized_name).join(' / ')
  end

  def capitalized_name
    name.titleize
  end

  def self_and_descendants
    [self] + descendants.to_a
  end

  def self_and_descendant_ids
    [id] + descendant_ids
  end
end

class CommissionFactoryImporter < ApplicationRecord
  belongs_to :user

  has_many :products, dependent: :destroy
  has_many :commission_factory_categories, dependent: :destroy
  has_many :categories, through: :commission_factory_categories

  has_attached_file :csv
  validates_attachment_content_type :csv, content_type: ['text/plain', 'text/csv', 'application/vnd.ms-excel']
end

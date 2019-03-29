class CommissionFactoryCategory < ApplicationRecord
  belongs_to :category
  belongs_to :commission_factory_importer
end

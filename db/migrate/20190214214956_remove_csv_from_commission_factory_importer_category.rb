class RemoveCsvFromCommissionFactoryImporterCategory < ActiveRecord::Migration[5.0]
  def self.up
    remove_attachment :commission_factory_categories, :csv   
  end

  def self.down
    remove_attachment :commission_factory_categories, :csv   
  end 
end

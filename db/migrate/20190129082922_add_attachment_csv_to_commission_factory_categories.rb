class AddAttachmentCsvToCommissionFactoryCategories < ActiveRecord::Migration
  def self.up
    change_table :commission_factory_categories do |t|
      t.attachment :csv
    end
  end

  def self.down
    remove_attachment :commission_factory_categories, :csv
  end
end

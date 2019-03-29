class AddAttachmentToComissionFactoryImporter < ActiveRecord::Migration[5.0]
  def self.up
    change_table :commission_factory_importers do |t|
      t.attachment :csv
    end
  end

  def self.down
    remove_attachment :commission_factory_importers, :csv
  end
end

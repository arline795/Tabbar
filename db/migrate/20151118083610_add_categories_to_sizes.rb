class AddCategoriesToSizes < ActiveRecord::Migration
  def change
    add_reference :sizes, :category, index: true, foreign_key: true
  end
end

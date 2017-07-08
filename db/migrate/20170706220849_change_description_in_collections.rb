class ChangeDescriptionInCollections < ActiveRecord::Migration[5.0]
  def change
    remove_column :collections, :description, :string
    add_column :collections, :description, :text
  end
end

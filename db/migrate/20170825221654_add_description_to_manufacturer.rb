class AddDescriptionToManufacturer < ActiveRecord::Migration[5.0]
  def change
    add_column :manufacturers, :description, :text
  end
end

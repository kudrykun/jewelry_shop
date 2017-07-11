class RemoveManufacturerFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :manufacturer, :string
  end
end

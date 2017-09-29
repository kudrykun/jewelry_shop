class RenameMetalTypesProductsToMetalTypeProduct < ActiveRecord::Migration[5.0]
  def change
    rename_table :metal_types_products, :metal_type_products
  end
end

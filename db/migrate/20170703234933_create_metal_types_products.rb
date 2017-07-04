class CreateMetalTypesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :metal_types_products do |t|
      t.references :metal_type, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end

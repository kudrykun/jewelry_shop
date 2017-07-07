class CreateCategoriesProductTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_product_types do |t|
      t.references :categories, foreign_key: true
      t.references :product_types, foreign_key: true
    end
  end
end

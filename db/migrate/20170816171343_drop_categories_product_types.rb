class DropCategoriesProductTypes < ActiveRecord::Migration[5.0]
    def change
      drop_table :categories_product_types do |t|
        t.references :category, foreign_key: true
        t.references :product_type, foreign_key: true
      end
    end
end

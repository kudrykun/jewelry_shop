class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :artikul
      t.numeric :price
      t.references :metal_color, foreign_key: true
      t.numeric :weight
      t.references :product_type, foreign_key: true
      t.references :sale_size, foreign_key: true
      t.numeric :old_size
      t.boolean :to_main_page
      t.string :manufacturer
      t.integer :priority

      t.timestamps
    end
  end
end

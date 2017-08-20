class DropProductsSizes < ActiveRecord::Migration[5.0]
  def change
    drop_table :products_sizes, id: false do |t|
      t.references :size, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end

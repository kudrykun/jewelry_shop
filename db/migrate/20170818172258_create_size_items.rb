class CreateSizeItems < ActiveRecord::Migration[5.0]
  def change
    create_table :size_items do |t|
      t.references :product, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :size, foreign_key: true

      t.timestamps
    end
  end
end

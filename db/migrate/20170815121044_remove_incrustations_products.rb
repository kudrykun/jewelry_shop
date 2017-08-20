class RemoveIncrustationsProducts < ActiveRecord::Migration[5.0]
  def change
    drop_table :incrustations_products do |t|
      t.references :incrustation, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end

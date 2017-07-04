class CreateIncrustationsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :incrustations_products do |t|
      t.references :incrustation, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end

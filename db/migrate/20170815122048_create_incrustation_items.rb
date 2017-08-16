class CreateIncrustationItems < ActiveRecord::Migration[5.0]
  def change
    create_table :incrustation_items do |t|
      t.integer :quantity
      t.numeric :weight
      t.string :purity
      t.references :incrustation, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end

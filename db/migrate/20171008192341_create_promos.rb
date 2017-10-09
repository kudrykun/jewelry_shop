class CreatePromos < ActiveRecord::Migration[5.0]
  def change
    create_table :promos do |t|
      t.string :title
      t.text :text
    end
  end
end

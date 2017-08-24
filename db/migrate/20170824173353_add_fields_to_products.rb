class AddFieldsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :visible, :boolean
    add_column :products, :recommendation, :boolean
    add_column :products, :hit, :boolean
    add_column :products, :title_light, :string
  end
end

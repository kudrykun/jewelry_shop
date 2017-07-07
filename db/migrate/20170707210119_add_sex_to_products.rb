class AddSexToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sex, :integer, default: 3
  end
end

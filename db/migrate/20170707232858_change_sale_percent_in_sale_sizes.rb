class ChangeSalePercentInSaleSizes < ActiveRecord::Migration[5.0]
  def change
    change_column :sale_sizes, :sale_percent, :integer
  end
end

class ChangeColumnsDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:products, :visible, true)
    change_column_default(:products, :recommendation, false)
    change_column_default(:products, :hit, false)
  end
end

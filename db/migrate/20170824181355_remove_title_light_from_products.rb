class RemoveTitleLightFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :title_light, :string
  end
end

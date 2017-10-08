class AddToNavToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :to_nav, :boolean, default: false
  end
end

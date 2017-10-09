class AddImageFieldsCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :preview
    add_reference :categories, :banner
  end
end

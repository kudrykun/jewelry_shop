class AddImageFieldsToManufacturer < ActiveRecord::Migration[5.0]
  def change
    add_reference :manufacturers, :index
    add_reference :manufacturers, :slide
  end
end

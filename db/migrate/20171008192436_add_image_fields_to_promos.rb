class AddImageFieldsToPromos < ActiveRecord::Migration[5.0]
  def change
    add_reference :promos, :picture
    add_reference :promos, :preview
  end
end

class AddImageFieldToSlides < ActiveRecord::Migration[5.0]
  def change
    add_reference :slides, :picture
  end
end

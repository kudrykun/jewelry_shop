class AddImageFieldToMainPageBlocks < ActiveRecord::Migration[5.0]
  def change
    add_reference :main_page_blocks, :picture
  end
end

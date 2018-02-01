class CreateMainPageBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :main_page_blocks do |t|
      t.string :title
      t.string :href
      t.integer :priority
      t.boolean :hide
      t.string :class_s, default: 's6'
      t.string :class_sm, default: 'sm4'
    end
  end
end

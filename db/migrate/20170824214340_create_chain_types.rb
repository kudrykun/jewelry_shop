class CreateChainTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :chain_types do |t|
      t.string :title
    end
  end
end

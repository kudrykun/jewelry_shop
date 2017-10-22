class AddFieldsToActivityLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :user_name, :string
    add_column :activity_logs, :entity_name, :string
  end
end

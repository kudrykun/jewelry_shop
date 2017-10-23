class AddControllerNameToActivityLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :controller_name, :string
  end
end

class AddRecoverableToDevise < ActiveRecord::Migration[5.0]
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
  end

  def down
    remove_columns :users, :reset_password_token, :reset_password_sent_at
  end
end

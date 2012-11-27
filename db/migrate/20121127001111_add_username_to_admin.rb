class AddUsernameToAdmin < ActiveRecord::Migration
  def up
    add_column :admins, :username, :string
  end

  def down
    remove_column :admins, :username
  end
end

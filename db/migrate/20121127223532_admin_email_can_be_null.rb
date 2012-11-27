class AdminEmailCanBeNull < ActiveRecord::Migration
  def up
    change_column :admins, :email, :string, :default => nil, :null => true
  end

  def down
    change_column :admins, :email, :string, :default => "", :null => false
  end
end

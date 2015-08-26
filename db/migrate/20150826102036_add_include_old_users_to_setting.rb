class AddIncludeOldUsersToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :include_old_users, :boolean
  end
end

class AddUseLocalizedToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :use_localized, :boolean
  end
end

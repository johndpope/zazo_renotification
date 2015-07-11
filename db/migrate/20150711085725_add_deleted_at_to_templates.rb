class AddDeletedAtToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :deleted_at, :datetime
    add_index :templates, :deleted_at
  end
end

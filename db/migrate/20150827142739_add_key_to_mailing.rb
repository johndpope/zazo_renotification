class AddKeyToMailing < ActiveRecord::Migration
  def change
    add_column :mailings, :key, :string
  end
end

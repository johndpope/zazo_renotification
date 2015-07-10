class AddIsSentToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_sent, :boolean
  end
end

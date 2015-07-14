class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :target
      t.text :title
      t.text :body
      t.timestamp :send_at
      t.string :status
      t.references :program, index: true, foreign_key: true
      t.references :sequence, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

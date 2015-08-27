class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.string :phone
      t.text :message
      t.text :status

      t.timestamps null: false
    end
  end
end

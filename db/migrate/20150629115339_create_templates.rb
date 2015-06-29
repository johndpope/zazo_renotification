class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :kind
      t.string :name
      t.text :title
      t.text :body

      t.timestamps null: false
    end
    add_index :templates, :name, unique: true
  end
end

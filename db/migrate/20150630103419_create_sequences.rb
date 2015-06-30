class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.references :template, index: true, foreign_key: true
      t.float :delay_hours

      t.timestamps null: false
    end
  end
end

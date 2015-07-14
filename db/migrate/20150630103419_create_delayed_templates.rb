class CreateDelayedTemplates < ActiveRecord::Migration
  def change
    create_table :delayed_templates do |t|
      t.references :template, index: true, foreign_key: true
      t.float :delay_hours

      t.timestamps null: false
    end
  end
end

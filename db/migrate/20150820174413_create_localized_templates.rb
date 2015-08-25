class CreateLocalizedTemplates < ActiveRecord::Migration
  def change
    create_table :localized_templates do |t|
      t.text :title
      t.text :body
      t.references :template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

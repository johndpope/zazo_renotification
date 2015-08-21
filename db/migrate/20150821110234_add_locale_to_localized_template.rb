class AddLocaleToLocalizedTemplate < ActiveRecord::Migration
  def change
    add_column :localized_templates, :locale, :string
  end
end

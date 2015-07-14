class AddProgramToDelayedTemplates < ActiveRecord::Migration
  def change
    add_reference :delayed_templates, :program, index: true, foreign_key: true
  end
end

class AddProgramToSettings < ActiveRecord::Migration
  def change
    add_reference :settings, :program, index: true, foreign_key: true
  end
end

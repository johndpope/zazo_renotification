class AddProgramToConditions < ActiveRecord::Migration
  def change
    add_reference :conditions, :program, index: true, foreign_key: true
  end
end

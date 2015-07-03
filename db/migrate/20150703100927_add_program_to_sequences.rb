class AddProgramToSequences < ActiveRecord::Migration
  def change
    add_reference :sequences, :program, index: true, foreign_key: true
  end
end

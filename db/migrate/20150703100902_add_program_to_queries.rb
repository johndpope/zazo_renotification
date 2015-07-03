class AddProgramToQueries < ActiveRecord::Migration
  def change
    add_reference :queries, :program, index: true, foreign_key: true
  end
end

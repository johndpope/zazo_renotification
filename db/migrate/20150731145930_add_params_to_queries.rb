class AddParamsToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :params, :text
  end
end

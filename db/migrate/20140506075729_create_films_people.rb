class CreateFilmsPeople < ActiveRecord::Migration
  def change
    create_join_table :films, :people
  end
end

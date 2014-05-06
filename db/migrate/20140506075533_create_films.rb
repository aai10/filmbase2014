class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :name
      t.string :origin_name
      t.text :slogan
      t.belongs_to :country, index: true
      t.belongs_to :genre, index: true
      t.belongs_to :director, index: true
      t.integer :length
      t.integer :year
      t.string :trailer_url
      t.attachment :cover
      t.text :description

      t.timestamps
    end
  end
end

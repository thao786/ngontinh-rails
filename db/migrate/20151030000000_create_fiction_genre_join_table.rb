class CreateFictionGenreJoinTable < ActiveRecord::Migration
  def change
    create_table :fictions_genres, id: false do |t|
      t.integer :fiction_id
      t.integer :genre_id
    end
  end
end
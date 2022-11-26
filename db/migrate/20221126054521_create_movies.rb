class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.text :title, null: false
      t.integer :release_year, null: false
      t.text :review
      t.date :date_watched
      t.integer :rating
      t.text :image
      t.integer :length
      t.timestamps
    end
  end
end

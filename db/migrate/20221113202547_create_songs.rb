class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.text :title, null: false
      t.text :file_id
      t.integer :duration, null: false
      t.references :artist, foreign_key: true
      t.references :album, foreign_key: true
      t.timestamps
    end
  end
end

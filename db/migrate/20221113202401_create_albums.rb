class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.text :title, null: false
      t.references :artist, null: false, foreign_key: true
      t.timestamps
    end
  end
end

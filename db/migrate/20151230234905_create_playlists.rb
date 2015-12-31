class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.text :description
      t.integer :game_mode, null: false, default: 0
      t.boolean :active, null: false, default: false
      t.boolean :ranked, null: false, default: false
      t.timestamps null: false
      t.index :uid, unique: true
    end
  end
end

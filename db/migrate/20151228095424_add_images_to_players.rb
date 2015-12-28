class AddImagesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :spartan_image_url, :text
    add_column :players, :emblem_url, :text
    add_index :players, :gamertag, unique: true
  end
end

class AddSlugToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :slug, :text
    add_index :players, :slug, unique: true
    reversible do |direction|
      direction.up { execute("update players set slug = gamertag;") }
    end
    change_column_null :players, :slug, false
  end
end

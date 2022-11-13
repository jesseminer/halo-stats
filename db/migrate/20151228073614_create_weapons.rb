class CreateWeapons < ActiveRecord::Migration[4.2]
  def change
    create_table :weapons do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.string :weapon_type, null: false
      t.text :description
      t.text :image_url
      t.boolean :usable_by_player
      t.timestamps null: false
      t.index :uid, unique: true
    end
  end
end

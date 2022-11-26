class CreatePlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :players do |t|
      t.string :gamertag, null: false
      t.integer :spartan_rank, null: false
      t.timestamps null: false
    end
  end
end

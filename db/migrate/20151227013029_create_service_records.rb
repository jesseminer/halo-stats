class CreateServiceRecords < ActiveRecord::Migration
  def change
    create_table :service_records do |t|
      t.references :player, null: false, index: true, foreign_key: { name: 'fk_service_records_player_id' }
      t.integer :game_mode, null: false, default: 0
      t.integer :kills, null: false
      t.integer :assists, null: false
      t.integer :deaths, null: false
      t.integer :games_played, null: false
      t.integer :games_won, null: false
      t.integer :time_played, null: false
      t.timestamps null: false
      t.index [:player_id, :game_mode], unique: true
    end
  end
end

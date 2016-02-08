class AddGameModeToWeaponUsages < ActiveRecord::Migration
  def change
    add_column :weapon_usages, :game_mode, :integer, null: false, default: 0
    reversible do |dir|
      dir.up { remove_index :weapon_usages, [:player_id, :weapon_id] }
      dir.down { add_index :weapon_usages, [:player_id, :weapon_id], unique: true }
    end
    add_index :weapon_usages, :game_mode
    add_index :weapon_usages, [:game_mode, :player_id]
    add_index :weapon_usages, [:game_mode, :player_id, :weapon_id], unique: true
  end
end

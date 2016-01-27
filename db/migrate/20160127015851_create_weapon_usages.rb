class CreateWeaponUsages < ActiveRecord::Migration
  def change
    integer_cols = %i[kills headshots damage_dealt shots_fired shots_hit time_used]
    create_table :weapon_usages do |t|
      t.references :player, null: false, index: true, foreign_key: { name: 'fk_weapon_usages_player_id' }
      t.references :weapon, null: false, index: true, foreign_key: { name: 'fk_weapon_usages_weapon_id' }
      integer_cols.each do |col|
        t.integer col, null: false, default: 0
      end
      t.timestamps null: false
      t.index [:player_id, :weapon_id], unique: true
    end
  end
end

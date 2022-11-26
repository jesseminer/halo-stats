class CreatePlaylistRanks < ActiveRecord::Migration[4.2]
  def change
    create_table :playlist_ranks do |t|
      t.references :player, null: false, index: true, foreign_key: { name: 'fk_playlist_ranks_player_id' }
      t.references :season, null: false, index: true, foreign_key: { name: 'fk_playlist_ranks_season_id' }
      t.references :playlist, null: false, foreign_key: { name: 'fk_playlist_ranks_playlist_id' }
      t.references :csr_tier, null: false, foreign_key: { name: 'fk_playlist_ranks_csr_tier_id' }
      t.integer :progress_percent
      t.integer :csr
      t.integer :rank
      t.timestamps null: false
      t.index [:player_id, :season_id, :playlist_id], unique: true
    end
  end
end

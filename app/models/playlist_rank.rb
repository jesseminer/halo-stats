class PlaylistRank < ActiveRecord::Base
  belongs_to :csr_tier
  belongs_to :player
  belongs_to :playlist
  belongs_to :season

  validates :player_id, uniqueness: { scope: [:playlist_id, :season_id] }
end

class PlaylistRank < ActiveRecord::Base
  belongs_to :csr_tier
  belongs_to :player
  belongs_to :playlist
  belongs_to :season

  validates :player_id, uniqueness: { scope: [:playlist_id, :season_id] }

  scope :current_season, -> { where(season_id: Season.current.id) }
  scope :highest_first, -> { joins(:csr_tier).order('csr_tiers.identifier desc') }
end

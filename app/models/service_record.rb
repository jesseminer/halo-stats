class ServiceRecord < ActiveRecord::Base
  enum game_mode: { arena: 0, warzone: 1 }

  belongs_to :player

  validates :player_id, uniqueness: { scope: :game_mode }

  def kd_ratio
    kills.to_f / deaths
  end

  def win_percentage
    games_won.to_f / games_played * 100
  end
end

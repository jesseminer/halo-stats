class PlaylistRanksController < ApplicationController
  def index
    ranks = Player.find(params[:player_id]).playlist_ranks.highest_first.preload(:csr_tier, :playlist)
    render json: {
      playlist_ranks: ranks.map { |pr| PlaylistRankSerializer.serialize(pr) },
      seasons: Season.order(start_time: :desc).map { |s| SeasonSerializer.serialize(s) }
    }
  end
end

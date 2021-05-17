class PlaylistRanksController < ApplicationController
  def index
    ranks = Player.find(params[:player_id]).playlist_ranks.highest_first.preload(:csr_tier, :playlist)
    render json: {
      playlist_ranks: PlaylistRankSerializer.serialize_list(ranks),
      seasons: SeasonSerializer.serialize_list(Season.order(start_time: :desc))
    }
  end
end

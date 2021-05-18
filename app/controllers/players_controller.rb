class PlayersController < ApplicationController
  def index
    render json: Player.order(created_at: :desc).limit(5)
  end

  def show
    respond_to do |format|
      format.html { render 'landing/show' }
      format.json { render json: PlayerSerializer.for_profile(Player.find(params[:id])) }
    end
  end

  def update
    update_profile(Player.find(params[:id]).gamertag)
  end

  def update_ranks
    player = Player.find(params[:id])
    season = Season.find(params[:season_id])
    season.update_ranks(player)

    ranks = player.playlist_ranks.where(season: season).highest_first.preload(:csr_tier, :playlist)
    render json: {
      ranks: PlaylistRankSerializer.serialize_list(ranks),
      season_completed: season.end_time&.past?,
      season_id: season.id
    }
  end

  def search
    gt = params[:gamertag].gsub(/[^A-Za-z0-9 ]/, '').strip
    if gt.present?
      player = Player.find_by_gamertag(gt)
      player.present? ? render(json: { slug: player.slug }) : update_profile(gt)
    else
      render json: { error: 'Please enter a valid gamertag' }, status: 400
    end
  end

  private

  def update_profile(gamertag)
    svc = FetchPlayer.new(gamertag)
    svc.update
    render json: PlayerSerializer.for_profile(svc.player)
  rescue CustomErrors::PlayerNotFound => e
    render json: { error: "We could not find the player \"#{gamertag}\"" }, status: 400
  end
end

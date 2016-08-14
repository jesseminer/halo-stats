class PlayersController < ApplicationController
  def index
    render json: Player.order(created_at: :desc).limit(5)
  end

  def show
    respond_to do |format|
      format.html { render text: '', layout: 'application' }
      format.json { render json: PlayerSerializer.for_profile(Player.find(params[:id])) }
    end
  end

  def update
    player = Player.find(params[:id])
    update_and_go_to_profile(player.gamertag)
  end

  def search
    gt = params[:gamertag].gsub(/[^A-Za-z0-9 ]/, '').strip
    if gt.present?
      player = Player.find_by_gamertag(gt)
      if player.present?
        render json: { slug: player.slug }
      else
        render json: { error: "We could not find the player \"#{gt}\"" }, status: 400
      end
    else
      render json: { error: 'Please enter a valid gamertag' }, status: 400
    end
  end

  private

  def weapon_usage_stats
    @player.weapon_usages.joins(:weapon)
      .select('weapon_usages.*, (weapon_usages.kills::float / weapon_usages.time_used * 60) as kpm')
      .where('weapon_usages.time_used >= 120')
      .preload(:weapon).order('kpm desc')
  end

  def update_and_go_to_profile(gamertag)
    svc = FetchPlayer.new(gamertag)
    svc.update
    redirect_to player_path(svc.player)
  rescue CustomErrors::PlayerNotFound => e
    flash['error'] = "We could not find the player \"#{gamertag}\""
    redirect_to root_path
  end
end

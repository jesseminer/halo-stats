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
    update_profile(Player.find(params[:id]).gamertag)
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

  def weapon_usage_stats
    @player.weapon_usages.joins(:weapon)
      .select('weapon_usages.*, (weapon_usages.kills::float / weapon_usages.time_used * 60) as kpm')
      .where('weapon_usages.time_used >= 120')
      .preload(:weapon).order('kpm desc')
  end

  def update_profile(gamertag)
    svc = FetchPlayer.new(gamertag)
    svc.update
    render json: PlayerSerializer.for_profile(svc.player)
  rescue CustomErrors::PlayerNotFound => e
    render json: { error: "We could not find the player \"#{gamertag}\"" }, status: 400
  end
end

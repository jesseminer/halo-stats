class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @weapon_stats = weapon_usage_stats
  end

  def update
    player = Player.find(params[:id])
    update_and_go_to_profile(player.gamertag)
  end

  def search
    gt = params[:gamertag].gsub(/[^A-Za-z0-9 ]/, '').strip
    if gt.present?
      player = Player.find_by_gamertag(gt)
      player.present? ? redirect_to(player_path(player)) : update_and_go_to_profile(gt)
    else
      flash['error'] = 'Please enter a valid gamertag'
      redirect_to root_path
    end
  end

  private

  def weapon_usage_stats
    @player.weapon_usages.joins(:weapon)
      .select('weapon_usages.*, (weapon_usages.kills::float / weapon_usages.time_used * 60) as kpm')
      .where('weapon_usages.time_used > 300')
      .where(weapons: { weapon_type: ['Standard', 'Power'] })
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

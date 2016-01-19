class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
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

  def update_and_go_to_profile(gamertag)
    svc = FetchPlayer.new(gamertag)
    svc.update
    redirect_to player_path(svc.player)
  rescue CustomErrors::PlayerNotFound => e
    flash['error'] = "We could not find the player \"#{gamertag}\""
    redirect_to root_path
  end
end

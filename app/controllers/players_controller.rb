class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end

  def update
    player = Player.find(params[:id])
    FetchPlayer.new(player.gamertag).update
    redirect_to player_path(player)
  end

  def search
    player = Player.find_by_gamertag(params[:gamertag])
    if player.present?
      redirect_to player_path(player)
    else
      svc = FetchPlayer.new(params[:gamertag])
      svc.update
      redirect_to player_path(svc.player)
    end
  end
end

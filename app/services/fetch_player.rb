class FetchPlayer
  def initialize(gamertag)
    @player = Player.find_by('lower(gamertag) = lower(?)', gamertag) || Player.new(gamertag: gamertag)
  end

  def update
    json = ApiClient.arena_stats(@player.gamertag)
    @player.update!(gamertag: json['PlayerId']['Gamertag'], spartan_rank: json['SpartanRank'])
    update_arena_svc_record(json['ArenaStats'])
  end

  private

  def update_arena_svc_record(json)
    arena_sr = ServiceRecord.arena.find_or_initialize_by(player: @player)
    arena_sr.update!(
      kills: json['TotalSpartanKills'],
      assists: json['TotalAssists'],
      deaths: json['TotalDeaths'],
      games_played: json['TotalGamesCompleted'],
      games_won: json['TotalGamesWon']
    )
  end
end

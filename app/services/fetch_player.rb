class FetchPlayer
  attr_reader :player

  def initialize(gamertag)
    @player = Player.find_by_gamertag(gamertag) || Player.new(gamertag: gamertag)
  end

  def update
    json = ApiClient.arena_stats(@player.gamertag)
    @player.update!(gamertag: json['PlayerId']['Gamertag'], spartan_rank: json['SpartanRank'])
    update_arena_svc_record(json['ArenaStats'])

    wz_json = ApiClient.warzone_stats(@player.gamertag)
    update_warzone_svc_record(wz_json['WarzoneStat'])
  end

  private

  def svc_record_fields(json)
    {
      kills: json['TotalSpartanKills'],
      assists: json['TotalAssists'],
      deaths: json['TotalDeaths'],
      games_played: json['TotalGamesCompleted'],
      games_won: json['TotalGamesWon'],
      time_played: ApiClient.parse_duration(json['TotalTimePlayed'])
    }
  end

  def update_arena_svc_record(json)
    ServiceRecord.arena.find_or_initialize_by(player: @player).update!(svc_record_fields(json))
  end

  def update_warzone_svc_record(json)
    ServiceRecord.warzone.find_or_initialize_by(player: @player).update!(svc_record_fields(json))
  end
end

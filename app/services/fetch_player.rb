class FetchPlayer
  attr_reader :player

  def initialize(gamertag)
    @player = Player.find_by_gamertag(gamertag) || Player.new(gamertag: gamertag)
  end

  def update
    json = api_client.arena_stats
    @player.update!(
      gamertag: json['PlayerId']['Gamertag'],
      spartan_rank: json['SpartanRank'],
      spartan_image_url: api_client.spartan_image,
      emblem_url: api_client.emblem
    )
    update_arena_svc_record(json['ArenaStats'])
    update_warzone_svc_record(api_client.warzone_stats['WarzoneStat'])
  end

  private

  def api_client
    @_api_client ||= ApiClient.new(@player.gamertag)
  end

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

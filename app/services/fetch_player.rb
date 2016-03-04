class FetchPlayer
  attr_reader :player

  def initialize(gamertag)
    @player = Player.find_by_gamertag(gamertag) || Player.new(gamertag: gamertag)
  end

  def update
    raise CustomErrors::PlayerNotFound if @player.gamertag.length > 15
    json = api_client.arena_stats
    raise CustomErrors::PlayerNotFound if json['SpartanRank'] == 0

    update_arena_svc_record(json['ArenaStats'])
    update_playlist_ranks(json['ArenaStats']['ArenaPlaylistStats'])
    update_weapon_stats(json['ArenaStats']['WeaponStats'], :arena)

    warzone_json = api_client.warzone_stats['WarzoneStat']
    update_warzone_svc_record(warzone_json)
    update_weapon_stats(warzone_json['WeaponStats'], :warzone)

    @player.update!(
      gamertag: json['PlayerId']['Gamertag'],
      spartan_rank: json['SpartanRank'],
      spartan_image_url: api_client.spartan_image,
      emblem_url: api_client.emblem,
      refreshed_at: Time.current
    )
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

  def update_playlist_ranks(json)
    Season.current.update_ranks(@player, json)
    Season.where('end_time > ?', @player.refreshed_at || '2015-01-01').each do |s|
      s.update_ranks(@player)
    end
  end

  def update_warzone_svc_record(json)
    ServiceRecord.warzone.find_or_initialize_by(player: @player).update!(svc_record_fields(json))
  end

  def update_weapon_stats(json, game_mode)
    json.each do |data|
      weapon = Weapon.find_by(uid: data['WeaponId']['StockId'])
      if weapon.nil?
        Rails.logger.info("No weapon found with uid #{data['WeaponId']['StockId']}")
        next
      end

      weapon_usages = game_mode == :arena ? WeaponUsage.arena : WeaponUsage.warzone

      weapon_usages.find_or_initialize_by(player: @player, weapon: weapon).update!(
        kills: data['TotalKills'],
        headshots: data['TotalHeadshots'],
        damage_dealt: data['TotalDamageDealt'].to_f.round,
        shots_fired: data['TotalShotsFired'],
        shots_hit: data['TotalShotsLanded'],
        time_used: ApiClient.parse_duration(data['TotalPossessionTime'])
      )
    end
  end
end

class FetchPlayer
  attr_reader :player

  def initialize(gamertag)
    @player = Player.find_by_gamertag(gamertag) || Player.new(gamertag: gamertag)
  end

  def update
    raise CustomErrors::PlayerNotFound if @player.gamertag.length > 15
    json = api_client.arena_stats
    raise CustomErrors::PlayerNotFound if json['SpartanRank'] == 0

    @player.update!(
      gamertag: json['PlayerId']['Gamertag'],
      spartan_rank: json['SpartanRank'],
      spartan_image_url: api_client.spartan_image,
      emblem_url: api_client.emblem
    )
    update_arena_svc_record(json['ArenaStats'])
    update_warzone_svc_record(api_client.warzone_stats['WarzoneStat'])
    update_playlist_ranks(json['ArenaStats']['ArenaPlaylistStats'])
    update_weapon_stats(json['ArenaStats']['WeaponStats'])
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
    json.each do |attrs|
      csr_attrs = attrs['Csr']
      next if csr_attrs.blank?

      PlaylistRank.find_or_initialize_by(
        player: @player,
        season: Season.current,
        playlist: Playlist.find_by(uid: attrs['PlaylistId'])
      ).update!(
        csr_tier: CsrTier.find_by(identifier: "#{csr_attrs['DesignationId']}-#{csr_attrs['Tier']}"),
        progress_percent: csr_attrs['PercentToNextTier'],
        csr: csr_attrs['Csr'],
        rank: csr_attrs['Rank']
      )
    end
  end

  def update_warzone_svc_record(json)
    ServiceRecord.warzone.find_or_initialize_by(player: @player).update!(svc_record_fields(json))
  end

  def update_weapon_stats(json)
    json.each do |data|
      weapon = Weapon.find_by(uid: data['WeaponId']['StockId'])
      if weapon.nil?
        Rails.logger.info("No weapon found with uid #{data['WeaponId']['StockId']}")
        next
      end

      WeaponUsage.find_or_initialize_by(player: @player, weapon: weapon).update!(
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

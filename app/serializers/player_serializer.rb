class PlayerSerializer < BaseSerializer
  def self.for_profile(player)
    cols = [:completed_seasons, :emblem_url, :gamertag, :id, :slug, :spartan_image_url, :spartan_rank]
    player.as_json(only: cols).merge(
      arena_stats: serialize_service_record(player.service_records.arena.first),
      warzone_stats: serialize_service_record(player.service_records.warzone.first)
    )
  end

  def self.serialize_service_record(sr)
    {
      games_played: sr.games_played,
      kd_ratio: sr.kd_ratio.round(2),
      win_percentage: sr.win_percentage.round(1)
    }
  end
end

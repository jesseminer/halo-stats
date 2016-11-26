class Season < ActiveRecord::Base
  validates :uid, uniqueness: true

  def self.current
    order(:start_time).last
  end

  def update_ranks(player, json = nil)
    json ||= ApiClient.new(player.gamertag).arena_stats(uid)['ArenaStats']['ArenaPlaylistStats']

    json.each do |attrs|
      csr_attrs = attrs['Csr']
      next if csr_attrs.blank?

      PlaylistRank.find_or_initialize_by(
        player: player,
        season: self,
        playlist: Playlist.find_by(uid: attrs['PlaylistId'])
      ).update!(
        csr_tier: CsrTier.find_by(identifier: "#{csr_attrs['DesignationId']}-#{csr_attrs['Tier']}"),
        progress_percent: csr_attrs['PercentToNextTier'],
        csr: csr_attrs['Csr'],
        rank: csr_attrs['Rank']
      )
    end

    if end_time.past?
      player.completed_seasons << id
      player.save
    end
  end
end

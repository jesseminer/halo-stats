class PlaylistRankSerializer < BaseSerializer
  def self.playlist_rank_label(pr)
    name = pr.csr_tier.name
    case name
      when 'Onyx'
        "#{name} #{pr.csr}"
      when 'Champion'
        "#{name} #{pr.rank}"
      else
        "#{name} (#{pr.progress_percent}%)"
    end
  end

  def self.serialize(pr)
    {
      image_url: pr.csr_tier.image_url,
      label: playlist_rank_label(pr),
      playlist_name: pr.playlist.name,
      season_id: pr.season_id
    }
  end
end

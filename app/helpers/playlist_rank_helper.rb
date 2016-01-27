module PlaylistRankHelper
  def playlist_rank_label(pr)
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
end

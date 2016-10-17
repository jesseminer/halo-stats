class SeasonSerializer
  def self.serialize(s)
    s.as_json(only: [:id, :name])
  end
end

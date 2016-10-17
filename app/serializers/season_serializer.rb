class SeasonSerializer < BaseSerializer
  def self.serialize(s)
    s.as_json(only: [:id, :name])
  end
end

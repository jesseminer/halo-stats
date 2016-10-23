class WeaponUsageSerializer < BaseSerializer
  def self.serialize(wu)
    wu.as_json(only: [:game_mode, :image_url, :kills, :name, :weapon_type])
      .merge(kpm: wu.kpm.round(2))
  end
end

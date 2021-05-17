class WeaponUsageSerializer < BaseSerializer
  def self.serialize(wu)
    wu.as_json(only: [:game_mode, :image_url, :kills, :name])
      .merge(kpm: wu.kpm.round(2), standard_weapon: wu.weapon_type == 'Standard')
  end
end

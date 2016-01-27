class WeaponUsage < ActiveRecord::Base
  belongs_to :player
  belongs_to :weapon

  validates :player_id, uniqueness: { scope: :weapon_id }
end

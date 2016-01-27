class Weapon < ActiveRecord::Base
  has_many :weapon_usages

  validates :uid, uniqueness: true
end

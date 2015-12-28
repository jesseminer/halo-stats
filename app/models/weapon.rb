class Weapon < ActiveRecord::Base
  validates :uid, uniqueness: true
end

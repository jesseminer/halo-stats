class Playlist < ActiveRecord::Base
  enum game_mode: %i[arena warzone campaign custom]
  validates :uid, uniqueness: true
end

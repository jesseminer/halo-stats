class Player < ActiveRecord::Base
  has_many :playlist_ranks
  has_many :service_records

  validates :gamertag, uniqueness: true

  def self.find_by_gamertag(gt)
    find_by('lower(gamertag) = lower(?)', gt)
  end
end

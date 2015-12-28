class Player < ActiveRecord::Base
  has_many :service_records

  def self.find_by_gamertag(gt)
    find_by('lower(gamertag) = lower(?)', gt)
  end
end

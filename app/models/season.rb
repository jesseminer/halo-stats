class Season < ActiveRecord::Base
  validates :uid, uniqueness: true

  def self.current
    order(:start_time).last
  end
end

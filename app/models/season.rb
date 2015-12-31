class Season < ActiveRecord::Base
  validates :uid, uniqueness: true
end

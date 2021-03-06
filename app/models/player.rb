class Player < ActiveRecord::Base
  has_many :playlist_ranks, dependent: :destroy
  has_many :service_records, dependent: :destroy
  has_many :weapon_usages, dependent: :destroy

  validates :gamertag, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_validation { self.slug = gamertag.parameterize }

  def self.find_by_gamertag(gt)
    find_by('lower(gamertag) = lower(?)', gt)
  end

  def self.find(id_or_slug)
    id_or_slug.to_s.match(/^\d+$/) ? find_by!(id: id_or_slug) : find_by!(slug: id_or_slug)
  end

  def to_param
    slug
  end
end

module ApiMetadata
  module Weapons
    def self.load
      ApiClient.get('metadata/h5/metadata/weapons').each do |attrs|
        Weapon.find_or_initialize_by(uid: attrs['id']).update!(
          name: attrs['name'],
          weapon_type: attrs['type'],
          description: attrs['description'],
          image_url: attrs['smallIconImageUrl'],
          usable_by_player: attrs['isUsableByPlayer']
        )
      end
    end
  end
end

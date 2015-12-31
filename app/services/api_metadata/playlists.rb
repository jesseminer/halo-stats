module ApiMetadata
  module Playlists
    def self.load
      ApiClient.get('metadata/h5/metadata/playlists').each do |attrs|
        Playlist.find_or_initialize_by(uid: attrs['id']).update!(
          name: attrs['name'],
          description: attrs['description'],
          game_mode: attrs['gameMode'].downcase,
          active: attrs['isActive'],
          ranked: attrs['isRanked']
        )
      end
    end
  end
end

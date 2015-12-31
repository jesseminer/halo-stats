module ApiMetadata
  module Seasons
    def self.load
      ApiClient.get('metadata/h5/metadata/seasons').each do |attrs|
        Season.find_or_initialize_by(uid: attrs['id']).update!(
          name: attrs['name'],
          start_time: attrs['startDate'],
          end_time: attrs['endDate']
        )
      end
    end
  end
end

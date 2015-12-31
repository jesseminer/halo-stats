module ApiMetadata
  module CsrTiers
    def self.load
      ApiClient.get('metadata/h5/metadata/csr-designations').each do |attrs|
        designation = attrs['name']

        attrs['tiers'].each do |tier|
          identifier = "#{attrs['id']}-#{tier['id']}"
          name = %w[Unranked Onyx Champion].include?(designation) ?
            designation :
            "#{designation} #{tier['id']}"

          CsrTier.find_or_initialize_by(identifier: identifier).update!(
            identifier: identifier,
            name: name,
            image_url: tier['iconImageUrl']
          )
        end
      end
    end
  end
end

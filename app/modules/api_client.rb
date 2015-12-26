module ApiClient
  def self.get(path)
    uri = URI("https://www.haloapi.com/#{path}")
    req = Net::HTTP::Get.new(uri)
    req['Ocp-Apim-Subscription-Key'] = Rails.application.config.halo_api_key
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    JSON.parse(response.body)
  end
end

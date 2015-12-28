module ApiClient
  def self.get(path, params = {})
    uri = URI("https://www.haloapi.com/#{path}")
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(uri)
    req['Ocp-Apim-Subscription-Key'] = Rails.application.config.halo_api_key
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    JSON.parse(response.body)
  end

  def self.arena_stats(gamertag)
    get('stats/h5/servicerecords/arena', players: gamertag)['Results'][0]['Result']
  end

  def self.parse_duration(d)
    days = d.match(/(\d+)D/).try(:[], 1).to_i
    hours = d.match(/(\d+)H/).try(:[], 1).to_i
    minutes = d.match(/(\d+)M/).try(:[], 1).to_i
    seconds = d.match(/(\d+)(\.\d+)?S/).try(:[], 1).to_i

    days * 86400 + hours * 3600 + minutes * 60 + seconds
  end
end

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HaloStats
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
    config.eager_load_paths += ["#{config.root}/lib"]

    config.halo_api_key = ENV.fetch('HALO_API_KEY')
  end
end

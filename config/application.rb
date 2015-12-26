require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HaloStats
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.halo_api_key = ENV.fetch('HALO_API_KEY')
  end
end

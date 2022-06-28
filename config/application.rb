require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NbpCurrencyApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Memcache
    config.cache_store = :mem_cache_store, ENV.fetch('MEMCACHE_URL', 'localhost:11211'), {
      namespace: 'NbpCurrencyApi', expires_in: 1.day, compress: true,
      compression_min_size: 1_048_575, pool_size: 32, pool_timeout: 15,
      socket_timeout: 10, socket_max_failures: 10, socket_failure_delay: 0.25
    }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

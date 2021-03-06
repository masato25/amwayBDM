require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AmwayBDM
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = 'Beijing'
    # config.active_record.default_timezone = :local
    # config.i18n.fallbacks = true
    config.i18n.default_locale = "en"
    # config.i18n.default_locale = "cn"
  end
end

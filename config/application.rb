require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Esales
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # VENDOR_CSS_PATH = Rails.root.join("vendor", "assets", "stylesheets")
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.assets.enabled = false

    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :bn

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    # config.assets.initialize_on_precompile = false
    #config.assets.precompile += %w( *.js *.scss *.coffee *.css )

    # config.assets.precompile += %w(*.svg *.eot *.woff *.ttf *.gif *.png *.ico *.js *.scss *.coffee *.css )
    # config.assets.precompile << /\A(?!active_admin).*\.(js|css)\z/

    # Add webfonts folder which can contain icons used like fonts
    # config.assets.paths << Rails.root.join("app", "assets", "webfonts")
    # config.assets.paths << VENDOR_CSS_PATH

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

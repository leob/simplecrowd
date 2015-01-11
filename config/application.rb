require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Simplecrowd
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false

    config.assets.enabled = false

    # Test framework
    config.generators.test_framework false

    # generate controllers using standard scaffold template - this will include JSON responses automatically - see;
    # http://stackoverflow.com/questions/26569280/customize-rails-generate-scaffold/27291758#27291758
    config.app_generators.scaffold_controller :scaffold_controller

    # autoload lib path
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.generators do |g|
      g.assets false
      g.stylesheets false
      g.javascripts false
      # the following 2 lines are PROBABLY not needed anymore
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end

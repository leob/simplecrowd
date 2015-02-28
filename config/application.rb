require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# COMMENTED OUT THIS lINE BECAUSE WE DON'T USE SPROCKETS (built-in Rails asset pipeline):
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#
# Read the application.yml file into environment variables which you can then use in other config (YML/.rb) files, e.g.
# in database.yml, environments/development.rb etcetera. Approach was taken from:
#
# http://brandonhilkert.com/blog/flexible-rails-environment-configuration/
#
if File.exists?(File.expand_path('../application.yml', __FILE__))
   config = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
   config.merge! config.fetch(Rails.env, {})
   config.each do |key, value|
      ENV[key] ||= value.to_s unless value.kind_of? Hash
   end
end

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

      I18n.available_locales = [:en, :nl]
      #
      # We make "nl" the default locale meaning that in Dutch we don't need a locale prefix in the URLs
      # (so, /nl/projects is the same as /projects, but in English we need /en/projects).
      #
      # However we use "en" as the fallback as long as most of the texts have not been translated to Dutch yet.
      #
      config.i18n.default_locale = :nl
      config.i18n.fallbacks = [:en]

      # turn off warnings triggered by friendly_id
      #I18n.enforce_available_locales = false

      # WE DON'T USE SPROCKETS (built-in Rails asset pipeline):
      config.assets.enabled = false

      # Test framework
      config.generators.test_framework false

      #
      # UNCOMMENT the line below to generate controllers with JSON responses included:
      #
      #config.app_generators.scaffold_controller :scaffold_controller
      #
      # Uncommenting this line will cause "rails g scaffold ..." to include JSON responses in the controllers - see;
      #         http://stackoverflow.com/questions/26569280/customize-rails-generate-scaffold/27291758#27291758
      #

      # autoload lib path
      config.autoload_paths += %W(#{config.root}/lib)
      config.autoload_paths += Dir["#{config.root}/lib/**/"]

      config.generators do |g|
         # ADDED THESE 4 LINES BECAUSE WE DON'T USE SPROCKETS (built-in Rails asset pipeline):
         g.assets false
         g.stylesheets false
         g.javascripts false
         g.jbuilder false
         #g.test_framework :test_unit
         # the following 2 lines are PROBABLY not needed anymore
         #g.test_framework :rspec
         #g.integration_tool :rspec
         g.test_framework :minitest, spec: true
      end

      # Do not swallow errors in after_commit/after_rollback callbacks.
      config.active_record.raise_in_transactional_callbacks = true

      # See: http://robots.thoughtbot.com/content-compression-with-rack-deflater
      config.middleware.use Rack::Deflater
      config.middleware.insert_before ActionDispatch::Static, Rack::Deflater

      config.active_support.test_order = :sorted

      # ADDED ON 2015/02/17 - SEE: http://blog.8thlight.com/myles-megyesi/2013/10/10/ruby-derailed-fast-tests.html
      config.active_support.bare = true
   end
end

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module EventbriteThp
  class Application < Rails::Application
    config.load_defaults 8.1

    config.i18n.default_locale = :fr

    # Force UTF-8 encoding everywhere
    config.encoding = "utf-8"

    # Autoloading mode (zeitwerk)
    config.autoload_lib(ignore: %w(assets tasks))

    # Asset Pipeline (Propshaft) : inclure vendor pour Bootstrap et le thème
    config.assets.paths << Rails.root.join("vendor/assets")

    # Do not eager load in development
    config.eager_load = false

    # Generators config (cleaner app)
    config.generators do |g|
      g.helper false
      g.assets false
      g.stylesheets false
      g.javascripts false
      g.test_framework :test_unit, fixture: false
    end
  end
end
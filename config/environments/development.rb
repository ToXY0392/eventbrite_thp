Rails.application.configure do
  config.enable_reloading = true
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  config.active_storage.service = :local

  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

  config.active_support.deprecation = :log

  config.annotations.register_directories("app", "config", "lib", "test")
  config.annotations.register_extensions("rb", "erb", "html", "yml", "js")

  if defined?(BetterErrors)
    BetterErrors::Middleware.allow_ip! "0.0.0.0/0"
  end
end
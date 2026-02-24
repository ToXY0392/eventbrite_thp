Rails.application.configure do
  config.eager_load = true
  config.consider_all_requests_local = false

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.active_storage.service = :local

  config.log_level = :info

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "your-domain.com" }

  config.active_support.report_deprecations = false
end
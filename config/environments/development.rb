Rails.application.configure do
  # Reload code à chaque requête (dev mode classique)
  config.enable_reloading = true

  # Affiche les erreurs complètes dans le navigateur
  config.consider_all_requests_local = true

  # Cache désactivé en dev
  config.action_controller.perform_caching = false

  # Stockage local pour Active Storage (option par défaut)
  config.active_storage.service = :local

  # Serveur mail en local
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false

  # Logs plus verbeux
  config.active_support.deprecation = :log

  # NE PAS supprimer : support des annotations (rails notes)
  config.annotations.register_directories("app", "config", "lib", "test")
  config.annotations.register_extensions("rb", "erb", "html", "yml", "js")

  # 🔥 BetterErrors (WSL fix)
  if defined?(BetterErrors)
    BetterErrors::Middleware.allow_ip! "0.0.0.0/0"
  end

end
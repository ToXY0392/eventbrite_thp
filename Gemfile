# -------------------------------------
# Gemfile propre et compatible Rails 8.1
# -------------------------------------

source "https://rubygems.org"

ruby "3.4.2"

# Framework Rails complet
gem "rails", "~> 8.1"

# Base de données PostgreSQL
gem "pg", "~> 1.5"

# Pour générer de fausses données (seed)
gem "faker"

gem "devise"

# Chargement auto des variables .env (Gmail, Stripe, etc.)
gem "dotenv-rails", groups: [:development, :test]

# Paiement en ligne
gem "stripe"

# Serveur web conseillé pour Rails
gem "puma", "~> 7.2"

# Amélioration du temps de boot
gem "bootsnap", require: false

# FRONT (si jamais tu utilises CSS ou JS plus tard)
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Email parsing
gem "mail"

# -------------------------------------
# Groupe développement
# -------------------------------------
group :development do
  # Ouvre les mails dans le navigateur (test mailer)
  gem "letter_opener"

  # Console plus agréable
  gem "pry"

  # Débug d'erreurs ++
  gem "better_errors"
  gem "binding_of_caller"
end
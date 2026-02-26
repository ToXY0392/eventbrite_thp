# 🎟️ Eventbrite THP

A Rails application to manage events like Eventbrite.

## 📋 Prerequisites

- 💎 Ruby 3.4.2
- 🐘 PostgreSQL 9.3+
- 📦 Node.js (optional, for the asset pipeline)
- 💳 Compte **Stripe** (clés de test pour le paiement)
- 🖼️ **Active Storage** – images d'événements et avatars utilisateur
- 🎨 **Bootstrap 5** (thème sombre personnalisé)

**Main technologies:**
- 🚂 Rails 8.1
- 🔐 **Devise** – authentification (sign up, sign in, reset password)
- 💳 **Stripe** – paiement en ligne (cartes bancaires)
- 📱 **PWA** – Progressive Web App (Rails 8 native)
- 🎨 **Bootstrap 5** – UI et navbar
- 📧 **Mailer** – emails (letter_opener en dev pour prévisualisation)
- 🔧 **Faker** – données de test en français
- 🐛 **Better Errors** – pages d’erreur avec débogage interactif

## ⚙️ Installation

1. **Clone the repository**
```bash
git clone <repo-url>
cd eventbrite_thp
```

2. **Install dependencies**
```bash
bundle install
```

3. **Set up the database**
```bash
rails db:create
rails db:migrate
```

4. **Configure Stripe** (pour le paiement)
```bash
cp .env.example .env
# Remplir .env avec vos clés Stripe (https://dashboard.stripe.com/test/apikeys)
```

5. **Start the server**
```bash
bin/dev
```

The application will be accessible at `http://localhost:3000`

## 📝 Project Steps to Complete

Exercice **Eventbrite : Stripe et composants (partials)** – complété ✅

### 1. **Partials** ✅
- Partials extraits : `_event_card`, `_event_details`, `_event_form`, `_event_admin_buttons`, `_event_list_item`
- Réutilisés dans index, show, new, edit, users#show

### 2. **Stripe – Paiement** ✅
- Gem `stripe` et `dotenv-rails`
- `config/initializers/stripe.rb`
- `.env.example` en template (cp .env.example .env puis remplir les clés)
- Flux : bouton "Rejoindre" → `attendances#new` → `attendances#checkout` (Stripe Checkout) → `attendances#success`
- Annulation : redirection vers l'événement avec message d'erreur

### 3. **Espace admin organisateur** ✅
- Lien "Mon espace événement" sur `events#show` (visible uniquement par l’organisateur)
- `attendances#index` : liste des participants, boutons Modifier / Supprimer l’événement
- `before_action :ensure_event_admin` pour restreindre l’accès

### 4. **Bonus : Événements gratuits** ✅
- `price >= 0` dans le modèle Event – méthode `is_free?`
- Rejoindre directement sans Stripe pour les événements gratuits

### 5. **Seed & test** ✅
- `rails db:seed` – utilisateurs (password: password123), événements (dont 1 gratuit), attendances
- À tester : inscription, paiement Stripe (carte test 4242 4242 4242 4242), événement gratuit, espace admin

## 🏗️ Architecture

- 📊 **Models** : Business logic for events and users
- 🎮 **Controllers** : HTTP request handling
- 🎨 **Views** : ERB templates for rendering
- 🎭 **Assets** : Stylesheets and JavaScript




## 🚀 Deployment

The project uses **Kamal** for deployment. See `config/deploy.yml` for deployment parameters.

Docker build:
```bash
docker build -t eventbrite_thp .
```

## ✅ Testing

```bash
rails s
```

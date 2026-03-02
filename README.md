# 🎟️ Eventbrite THP

A Rails application to manage events like Eventbrite.

## 📋 Prerequisites

- 💎 **Ruby 3.4.2**
- 🐘 **PostgreSQL** 9.6+
- 💳 **Stripe account** – test keys for payment (paid events)
- 🖼️ **Active Storage** – event images and user avatars

**No Node.js required** – Propshaft (assets) and importmap-rails (JS).

**Main technologies:**
- 🚂 Rails 8.1
- 🔐 **Devise** – authentication (sign up, sign in, reset password)
- 💳 **Stripe** – online payment (credit cards)
- 📱 **PWA** – Progressive Web App (Rails 8 native)
- 🎨 **Bootstrap 5 + Bootswatch Minty** – UI and navbar
- 📧 **Mailer** – emails (letter_opener in dev for preview)
- 🔧 **Faker** – test data in French
- 🐛 **Better Errors** – error pages with interactive debugging

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

4. **Configure Stripe** (for payment)
```bash
cp .env.example .env
# Fill in .env with your Stripe keys (https://dashboard.stripe.com/test/apikeys)
```

5. **Start the server**
```bash
bin/dev
```

The application will be accessible at `http://localhost:3000`

## 📝 Project Steps to Complete

### Eventbrite Exercise: Stripe and Components ✅

1. **Partials** ✅ – `_event_card`, `_event_details`, `_event_form`, `_event_admin_buttons`, `_event_list_item`
2. **Stripe** ✅ – Payment via Checkout, free events without Stripe
3. **Organizer admin space** ✅ – `attendances#index`, edit/delete event
4. **Seed & test** ✅ – `rails db:seed`, test card 4242 4242 4242 4242

### Molecules and Organisms Exercise (Bootswatch Minty) ✅

5. **Navbar** ✅ – `shared/_navbar`
6. **Footer** ✅ – `shared/_footer`
7. **Authentication forms** ✅ – Devise (sign up, sign in, password)
8. **Banners** ✅ – Hero (home), small banner (sub-pages)
9. **Cards** ✅ – events, participants (horizontal), cities
10. **Card lists** ✅ – events grid, participants grid
11. **Comment** ✅ – molecule `_comment`, organism `_comments_section`
12. **Resource presentation** ✅ – 8+4 layout on `events#show`
13. **Image + text block** ✅ – `_feature_block` (element presentation)
14. **Custom organism** ✅ – Admin dashboard

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

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
rails db:seed
```

4. **Configure Stripe** (for payment)
```bash
cp .env.example .env
# Fill in .env with your Stripe keys (https://dashboard.stripe.com/test/apikeys)
```

5. **Start the server**
```bash
rails s
```

The application will be accessible at `http://localhost:3000`

## 📝 Project Steps to Complete

### Eventbrite Exercise: Stripe and Components ✅

1. **Partials** ✅ – `_event_card`, `_event_details`, `_event_form`, `_event_admin_buttons`, `_event_list_item`
2. **Stripe** ✅ – Payment via Checkout, free events without Stripe
3. **Organizer admin space** ✅ – `attendances#index`, edit/delete event
4. **Seed & test** ✅ – `rails db:seed`, test card 4242 4242 4242 4242

### Molecules and Organisms Exercise (Bootswatch Minty) ✅

5. **Navbar** ✅ – `layouts/_header`
6. **Footer** ✅ – `layouts/_footer`
7. **Flash / Alerts** ✅ – `layouts/_flash` with `bootstrap_class_for_flash` helper
8. **Authentication forms** ✅ – Devise (sign up, sign in, password)
9. **Banners** ✅ – Hero (`_hero_index`), small banner (`_banner_small`)
10. **Cards** ✅ – events, participants (horizontal), cities (`_city_card`)
11. **Card lists** ✅ – events grid (`_events_list`), participants grid (`_participants_section`)
12. **Comment** ✅ – molecule `_comment`, organism `_comments_section`
13. **Resource presentation** ✅ – 8+4 layout on `events#show` (`_event_main_card`, `_event_sidebar`)
14. **Image + text block** ✅ – `_feature_block` (element presentation)
15. **Custom organism** ✅ – Admin dashboard

### Rails et composants (Partials) ✅

- **Layouts** : `_header`, `_footer`, `_flash` (called from `application.html.erb`)
- **Shared** : `_hero_index`, `_banner_small`, `_testimonial`, `_feature_block`, `_cities_section`, `_city_card`, `_devise_card`
- **Events** : `_event_card`, `_event_main_card`, `_event_sidebar`, `_event_details`, `_event_form`, `_event_admin_buttons`, `_event_list_item`, `_events_list`
- **Users** : `_profile_card`, `_created_events_card`
- **Attendances** : `_admin_actions`, `_participants_section`, `_event_summary_card`, `_participant_card`
- **Admin** : `_users_table`, `_events_table`

## 🏗️ Architecture

- 📊 **Models** : Business logic for events and users
- 🎮 **Controllers** : HTTP request handling
- 🎨 **Views** : ERB templates with partials (component-based)
- 🎭 **Assets** : Stylesheets and JavaScript

## 🚀 Deployment

The project uses **Kamal** for deployment. See `config/deploy.yml` for deployment parameters.

Docker build:
```bash
docker build -t eventbrite_thp .
```

## ✅ Testing

```bash
rails test
```

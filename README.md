# 🎟️ Eventbrite THP

A Rails application to manage events like Eventbrite.

## 📋 Prerequisites

- 💎 Ruby 3.4.2
- 🐘 PostgreSQL 9.3+
- 📦 Node.js (optional for the asset pipeline)

**Main technologies:**
- 🚂 Rails 8.1
- 🔐 **Devise** – authentication (sign up, sign in, password recovery)
- 📱 **PWA** – Progressive Web App (Rails 8 native)
- 🎨 **Bootstrap 5** – UI and navbar
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

4. **Start the server**
```bash
bin/dev
```

The application will be accessible at `http://localhost:3000`

## 📝 Project Steps to Complete

Steps to complete the **Eventbrite: Devise, PWA and first views** exercise:

### 1. **Devise & PWA**
- Install Devise: `rails g devise:install` then `rails g devise User`
- Enable PWA: uncomment in `config/routes.rb` and `application.html.erb` the manifest/service-worker lines
- Configure `config.action_mailer.default_url_options` in `development.rb`
- Migrate: `rails db:migrate`

### 2. **Bootstrap & Navbar**
- Integrate Bootstrap 5 (CDN or importmap)
- Create a navbar with:
  - Home (events list)
  - Create event
  - Profile dropdown: My profile, Edit account, Sign out (when logged in)
  - Account dropdown: Sign up, Sign in (when logged out)
- Use `button_to` with `method: :delete` for sign out (avoid GET /users/sign_out conflict)

### 3. **Main pages**
- **Home page** (`events#index`): events list, create link, jumbotron style
- **Profile page** (`users#show`): user info, created events, "Edit email/password" link, `authenticate_user!` + ensure user only sees their own profile
- **Event page** (`events#show`): title, description, dates, location, price, attendees count, organizer
- **Create page** (`events#new`): form (title, description, start_date, duration, price, location), `authenticate_user!`, associate admin

### 4. **Join an event**
- Create `AttendancesController` with `create` action
- Nest routes: `resources :events do resources :attendances, only: [:create] end`
- Add `uniqueness` validation on `[user_id, event_id]` in Attendance model
- "Join event" button on show page (when logged in and not yet registered)
- Email to organizer on sign-up (AttendanceMailer)

### 5. **Edit / Delete an event**
- Add `edit`, `update`, `destroy` actions in `EventsController`
- `before_action :ensure_event_admin` – only the organizer can edit/delete
- Edit and Delete buttons on `events#show` (visible only to admin)
- Confirmation before deletion (`data: { turbo_confirm: "..." }`)



### 6. **Technical details**
- Route constraint for users: `constraints: { id: /\d+/ }` to avoid `/users/sign_out` matching
- Use `datetime_local_field` instead of `datetime_select` (avoids I18n errors with month_names)
- Add Devise `signed_up` translation at `registrations.signed_up` level

### 8. **Seed & test**
- `rails db:seed` – generates users (password: password123) and French events
- Test: sign up, sign in, create event, join, edit, delete

## 🏗️ Architecture

- 📊 **Models** : Business logic for events and users
- 🎮 **Controllers** : HTTP request handling
- 🎨 **Views** : ERB templates for rendering
- 🎭 **Assets** : Stylesheets and JavaScript


## 🗄️ Database

The project uses PostgreSQL with configuration in `config/database.yml`.

**Available environments:**
- 💻 `development` : Local development
- 🧪 `test` : Automated tests
- 🌐 `production` : Production environment

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

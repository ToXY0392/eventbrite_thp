# 🎟️ Eventbrite THP

A Rails application to manage events like Eventbrite.

## 📋 Prerequisites

- 💎 Ruby 3.4.2
- 🐘 PostgreSQL 9.3+
- 📦 Node.js (for the asset pipeline)

**Main dependencies (see Gemfile):**
- 🚂 Rails 8.1
- 📧 Mailer support (Gmail, Stripe integration)
- 🎨 Stimulus JS & Turbo Rails
- 🔧 **Faker (gem)** - seed data generation
- 🐛 **Better Errors (gem)** - enhanced error pages with interactive debugging

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

Follow these steps to build the Eventbrite application:

1. **Create Models**
   - `User` : Store user information and authentication
   - `Event` : Store event details (title, description, date, location)
   - `Attendance` : Link users to events (many-to-many relationship)

2. **Set Up Database Migrations**
   - Create tables for users, events, and attendances
   - Add proper associations and validations

3. **Build Controllers and Routes**
   - Implement RESTful routes for events
   - Create attendance management endpoints
   - Set up user authentication

4. **Create Views**
   - Event listing page
   - Event detail page
   - User registration and login
   - Attendance management interface

5. **Implement Mailers**
   - Send confirmation emails when user attends an event
   - Send event update notifications

6. **Add Validations & Business Logic**
   - Validate user and event inputs
   - Handle edge cases (duplicate attendance, etc.)

7. **Test Your Application**
   - Run `rails test` to execute test suite
   - Test all models, controllers, and mailers

## 🏗️ Architecture

- 📊 **Models** : Business logic for events and users
- 🎮 **Controllers** : HTTP request handling
- 🎨 **Views** : ERB templates for rendering
- 🎭 **Assets** : Stylesheets and JavaScript


## �🗄️ Database

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

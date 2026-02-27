require "faker"
require "securerandom"

Faker::Config.locale = :fr

puts "Cleaning database..."
Attendance.destroy_all
Event.destroy_all
User.destroy_all

puts "Creating users..."

10.times do |i|
  User.create!(
    email: "user#{i + 1}@yopmail.com",
    password: "password123",
    password_confirmation: "password123",
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 12),
    is_admin: (i == 0) # user1@yopmail.com est admin
  )
end

users = User.all

puts "Creating events..."

TITRES_EVENEMENTS = [
  "Concert de jazz en plein air",
  "Soirée networking entrepreneurs",
  "Atelier cuisine méditerranéenne",
  "Festival de street art",
  "Conférence sur l'innovation digitale",
  "Marathon de codage collaboratif",
  "Exposition photographie urbaine",
  "Cours de salsa pour débutants",
  "Dégustation vins biologiques",
  "Projection cinéma en plein air"
].freeze

DESCRIPTIONS_EVENEMENTS = [
  "Venez découvrir des artistes locaux et profiter d'une ambiance conviviale dans un cadre unique.",
  "Échangez avec des professionnels de tous secteurs et développez votre réseau dans une atmosphère détendue.",
  "Apprenez les bases de la cuisine méditerranéenne avec un chef passionné. Ingrédients fournis.",
  "Une journée dédiée à l'art urbain avec démonstrations en direct et œuvres éphémères.",
  "Découvrez les tendances du moment et les success stories de startups françaises.",
  "Rejoignez une équipe pour créer un projet en 24h. Nourriture et café offerts.",
  "Une sélection de clichés capturant la vie urbaine par des photographes amateurs et professionnels.",
  "Initiation à la salsa pour tous les niveaux. Venez avec votre partenaire ou trouvez-en un sur place.",
  "Découverte de vins naturels et biodynamiques accompagnée de fromages et charcuteries.",
  "Projection d'un film culte sous les étoiles. Apportez vos couvertures et votre pique-nique."
].freeze

# Créer des événements payants et gratuits
4.times do
  admin = users.sample

  Event.create!(
    start_date: Faker::Time.forward(days: rand(3..20), period: :evening),
    duration: [60, 90, 120, 180].sample,
    title: TITRES_EVENEMENTS.sample,
    description: DESCRIPTIONS_EVENEMENTS.sample,
    price: rand(5..150),
    location: Faker::Address.city,
    admin: admin,
    validated: true,
    reviewed: true
  )
end

# Un événement gratuit pour tester le flux sans Stripe
Event.create!(
  start_date: Faker::Time.forward(days: rand(3..20), period: :evening),
  duration: 60,
  title: "Apéro gratuit entre développeurs",
  description: "Rencontre informelle entre passionnés de code. Venez échanger autour d'un verre dans une ambiance conviviale.",
  price: 0,
  location: Faker::Address.city,
  admin: users.sample,
  validated: true,
  reviewed: true
)

events = Event.all

puts "Creating attendances..."

20.times do
  Attendance.create!(
    user: users.sample,
    event: events.sample,
    stripe_customer_id: "cus_#{SecureRandom.hex(6)}"
  )
end

puts "Seed completed successfully!"
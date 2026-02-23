require "faker"
require "securerandom"

puts "Cleaning database..."
Attendance.destroy_all
Event.destroy_all
User.destroy_all

puts "Creating users..."

10.times do |i|
  User.create!(
    email: "user#{i + 1}@yopmail.com",
    encrypted_password: "password#{i + 1}",
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 12)
  )
end

users = User.all

puts "Creating events..."

5.times do
  admin = users.sample

  Event.create!(
    start_date: Faker::Time.forward(days: rand(3..20), period: :evening),
    duration: [60, 90, 120, 180].sample,
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph_by_chars(number: 250),
    price: rand(5..150),
    location: Faker::Address.city,
    admin: admin
  )
end

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
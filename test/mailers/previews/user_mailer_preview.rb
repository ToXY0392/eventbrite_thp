# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def event_validated_email
    user  = User.first || User.new(email: "test@example.com", first_name: "Jean")
    event = Event.first || Event.new(title: "Mon événement", id: 1)
    UserMailer.event_validated_email(user, event)
  end

  def event_rejected_email
    user  = User.first || User.new(email: "test@example.com", first_name: "Jean")
    event = Event.first || Event.new(title: "Mon événement", id: 1)
    UserMailer.event_rejected_email(user, event)
  end
end

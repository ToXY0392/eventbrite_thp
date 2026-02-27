class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/login"

    mail(to: @user.email, subject: "Bienvenue sur Eventbrite THP 🎉")
  end

  def event_validated_email(user, event)
    @user  = user
    @event = event
    @url   = event_url(event)

    mail(to: @user.email, subject: "Votre événement « #{event.title} » a été validé ✅")
  end

  def event_rejected_email(user, event)
    @user  = user
    @event = event

    mail(to: @user.email, subject: "Votre événement « #{event.title} » n'a pas été validé")
  end
end
class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/login"

    mail(to: @user.email, subject: "Bienvenue sur Eventbrite THP 🎉")
  end
end
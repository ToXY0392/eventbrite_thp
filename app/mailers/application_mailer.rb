class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("GMAIL_LOGIN", "no-reply@eventbrite-thp.test")
  layout "mailer"
end
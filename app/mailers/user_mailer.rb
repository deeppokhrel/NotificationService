class UserMailer < ApplicationMailer
  def event_mailer(event)
    return if event["user_email"].blank?

    @item = event.dig("data", "items", "sku")
    @quantity = event.dig("data", "items", "quantity")

    mail(to: event["user_email"], subject: "Order Placed")
  end

  def welcome_mailer(email)
    @email = email
    mail(to: email, subject: "Welcome Account created")
  end
end

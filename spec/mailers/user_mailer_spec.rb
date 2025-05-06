require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "#event_mailer" do
    let(:event) do
      {
        "user_email" => "user@example.com",
        "data" => {
          "items" => {
            "sku" => "SKU123",
            "quantity" => 2
          }
        }
      }
    end

    it "sends an email to the user with correct subject" do
      mail = UserMailer.event_mailer(event)

      expect(mail.to).to eq([ "user@example.com" ])
      expect(mail.subject).to eq("Order Placed")
      expect(mail.body.encoded).to include("SKU123")
      expect(mail.body.encoded).to include("2")
    end

    it "does not send mail if user_email is blank" do
      event["user_email"] = ""
      mail = UserMailer.event_mailer(event)
      expect(mail.perform_deliveries).to be nil
    end
  end

  describe "#welcome_mailer" do
    let(:email) { "newuser@example.com" }

    it "sends a welcome email" do
      mail = UserMailer.welcome_mailer(email)

      expect(mail.to).to eq([ "newuser@example.com" ])
      expect(mail.subject).to eq("Welcome Account created")
      expect(mail.body.encoded).to include("newuser@example.com")
    end
  end
end

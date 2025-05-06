class UserCreatedNotificationWorker
  def self.start
    consumer = KafkaConsumer.new("customer-events")
    consumer.consume do |message|
      event = JSON.parse(message.value)
      next unless event["event_type"] == "customer.created"
      next if event["email"].blank?

      UserMailer.welcome_mailer(event["email"]).deliver_now
      puts "Welcome email sent to #{event["email"]}"
    end
  end
end

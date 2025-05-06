class OrderNotificationWorker
  def self.start
    consumer = KafkaConsumer.new("order-events")
    consumer.consume do |message|
      event = JSON.parse(message.value)
      next unless event["event"] == "order.placed"

      user_id = event["data"]["user_id"]
      UserMailer.event_mailer(event).deliver_now
      puts "Email sent to user ##{user_id} confirming order ##{event["data"]["order_id"]}"
    end
  end
end

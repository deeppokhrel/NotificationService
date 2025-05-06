Rails.application.config.after_initialize do
  Thread.new { OrderNotificationWorker.start }
end

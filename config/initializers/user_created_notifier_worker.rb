Rails.application.config.after_initialize do
  Thread.new { UserCreatedNotificationWorker.start }
end

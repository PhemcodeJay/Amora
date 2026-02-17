Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end

# Schedule recurring jobs
Sidekiq::Cron::Job.create(
  name: 'Daily match summary - every day at 9am',
  cron: '0 9 * * *',
  class: 'DailyMatchSummaryJob'
)

Sidekiq::Cron::Job.create(
  name: 'Clean up old notifications - every day at 2am',
  cron: '0 2 * * *',
  class: 'CleanupNotificationsJob'
)
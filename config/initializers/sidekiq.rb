Sidekiq.configure_server do |config|
  config.redis = {url: ENV.fetch("REDIS_SIDEKIQ_URL", "redis://localhost:6379/1")}

  config.on(:startup) do
    schedule_path = Rails.root.join("config/schedule.yml")
    Sidekiq.schedule = YAML.load_file(schedule_path)
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV.fetch("REDIS_SIDEKIQ_URL", "redis://localhost:6379/1")}
end

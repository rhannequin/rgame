require "sidekiq/testing"

Sidekiq.logger.level = Logger::ERROR

RSpec.configure do |config|
  config.before do
    Sidekiq::Worker.clear_all
  end
end

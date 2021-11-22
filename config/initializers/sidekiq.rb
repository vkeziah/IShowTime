# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(
      File.expand_path('../sidekiq-scheduler.yml', __dir__)
    )[Rails.env]
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

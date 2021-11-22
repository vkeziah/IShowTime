# frozen_string_literal: true

require 'database_cleaner/active_record'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].clean_with(:truncation)
  end

  config.append_after(:context) do
    DatabaseCleaner[:active_record].clean_with(:deletion, cache_tables: false)
  end

  config.before do
    DatabaseCleaner[:active_record].strategy = :transaction
  end

  config.before do
    DatabaseCleaner[:active_record].start
  end

  config.append_after do
    DatabaseCleaner[:active_record].clean
  end
end

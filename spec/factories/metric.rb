# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    identifier { Faker::Name.name }
    url { Faker::Internet.url }
    start_time { Time.now.in_time_zone }
    end_time { Time.now.in_time_zone }
    association :user, factory: :user
  end
end

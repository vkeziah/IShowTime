# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Name.name }
  end
end

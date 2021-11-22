# frozen_string_literal: true

class Metric < ApplicationRecord
  belongs_to :user

  validates :identifier, :url, :start_time, :end_time, :user_id, presence: true
end

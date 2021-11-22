# frozen_string_literal: true

class Movie < ApplicationRecord
  include AASM

  enum status: {
    waiting: 0,
    inprogress: 1,
    done: 2,
    failed: 3
  }

  enum priority: {
    low: 0,
    high: 1,
    critical: 2
  }

  after_create :queue_movie

  validates :title, presence: true

  aasm column: :status, enum: true do
    state :inprogress, initial: true
    state :waiting, :done, :failed

    event :inprogress do
      transitions from: [:waiting, :failed], to: :inprogress, after: proc { queue_movie }
    end
  end

  private

  def queue_movie
    SubmitWorker.perform_async(id) unless waiting?
  end
end

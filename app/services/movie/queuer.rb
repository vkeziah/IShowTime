# frozen_string_literal: true

class Movie
  class Queuer
    class << self
      delegate :call, to: :new
    end

    def call
      records.each do |record|
        SubmitWorker.perform_async(record.id)
      end
    end

    private

    def records
      MoviesQuery.call(schedule_date: Time.zone.today)
    end
  end
end

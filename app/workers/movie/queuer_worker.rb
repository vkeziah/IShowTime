# frozen_string_literal: true

class Movie
  class QueuerWorker < ApplicationWorker
    def perform
      Queuer.call
    end
  end
end

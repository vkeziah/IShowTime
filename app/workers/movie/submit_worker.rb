# frozen_string_literal: true

class Movie
  class SubmitWorker < ApplicationWorker
    def perform(movie_id)
      # We will do further process here, the following is dummy class where
      # we can implement our further process
      Process.call(movie_id)
    end
  end
end

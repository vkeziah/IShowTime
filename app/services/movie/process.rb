# frozen_string_literal: true

class Movie
  class Process
    class << self
      def call(movie_id)
        # This is just a dummy class create to illustrate further process of movie
        # when its called by Movie::SubmitWorker
        movie_id
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def index
        movies = MoviesQuery.call

        render json: movies
      end

      def create
        movie = Movie.create(movie_params)

        if movie.save
          render json: movie
        else
          render json: movie.errors, status: :unprocessable_entity
        end
      end

      private

      def movie_params
        params.require(:movie).permit(:title, :status, :priority)
      end
    end
  end
end

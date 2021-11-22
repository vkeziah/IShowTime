# frozen_string_literal: true

module Api
  module V1
    class MetricsController < ApplicationController
      def index
        metrics = MetricsQuery.call(user_id: @current_user_id)

        render json: metrics
      end
    end
  end
end

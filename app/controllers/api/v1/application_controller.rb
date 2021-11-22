# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ApplicationController
      protect_from_forgery with: :exception, unless: -> { request.format.json? }

      before_action :authenticate_api

      private

      def authenticate_api
        token = request.headers['Authorization']

        if token.present?
          begin
            user_id = AuthenticationTokenService.decode(token)
            @current_user = User.find(user_id)
          rescue ActiveRecord::RecordNotFound
            head :unauthorized
          end
        else
          head :unauthorized
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      protect_from_forgery with: :exception, unless: -> { request.format.json? }

      def create
        user = User.new(sign_up_params)

        if user.save
          token = AuthenticationTokenService.encode(user.id)
          render json: token.to_json
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end

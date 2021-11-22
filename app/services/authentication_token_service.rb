# frozen_string_literal: true

class AuthenticationTokenService
  SECRET = Rails.application.secrets.secret_key_base

  class << self
    def encode(id)
      JWT.encode({ id: id }, SECRET)
    end

    def decode(token)
      payload = JWT.decode(token, SECRET).first
      payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      nil
    end
  end
end

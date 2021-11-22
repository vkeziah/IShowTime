# frozen_string_literal: true

RSpec.describe AuthenticationTokenService do
  let(:user_id) { Faker::Number.number(digits: 2) }
  let(:secret) { Rails.application.secrets.secret_key_base }

  describe '.encode' do
    it 'returns authentication token' do
      expect(described_class.encode(user_id)).not_to be_nil
    end
  end

  describe '.decode' do
    it 'decodes authentication token' do
      token = described_class.encode(user_id)
      decoded_token = JWT.decode token, secret

      expect(decoded_token).to eql(
        [
          { 'id' => user_id },
          { 'alg' => 'HS256' }
        ]
      )
    end
  end
end

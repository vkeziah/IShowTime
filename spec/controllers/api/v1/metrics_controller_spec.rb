# frozen_string_literal: true

RSpec.describe Api::V1::MetricsController do
  let(:user) { create(:user) }
  let(:token) { AuthenticationTokenService.encode(user.id) }

  describe 'GET #index' do
    context 'when authorized user' do
      before do
        request.headers['Authorization'] = token

        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when unauthorized user' do
      before { get :index }

      it 'returns http unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe MetricsQuery do
  let(:metric) { create(:metric, user: user) }
  let(:user) { create(:user) }

  describe '.call' do
    context 'with default context' do
      before do
        create(:metric)
        metric
      end

      it 'returns all metrics' do
        metrics = described_class.call
        expect(metrics.size).to be(2)
      end
    end

    context 'with user_id' do
      before do
        create(:metric)
        metric
      end

      it 'returns metrics by user' do
        metrics = described_class.call(user_id: user.id)
        expect(metrics.size).to be(1)
      end
    end
  end
end

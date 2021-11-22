# frozen_string_literal: true

RSpec.describe Movie::QueuerWorker do
  it { is_expected.to be_processed_in('default') }

  describe '#perform' do
    before do
      allow(Movie::Queuer).to receive(:call)

      Sidekiq::Testing.inline! { described_class.perform_async }
    end

    it { expect(Movie::Queuer).to have_received(:call) }
  end
end

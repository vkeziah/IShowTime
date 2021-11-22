# frozen_string_literal: true

RSpec.describe Movie::SubmitWorker do
  it { is_expected.to be_processed_in('default') }

  describe '#perform' do
    let(:movie_id) { Faker::Number.number(digits: 2) }

    before do
      allow(Movie::Process)
        .to receive(:call)
        .with(movie_id)

      Sidekiq::Testing.inline! { described_class.perform_async(movie_id) }
    end

    it { expect(Movie::Process).to have_received(:call).with(movie_id) }
  end
end

# frozen_string_literal: true

RSpec.describe Movie::Queuer do
  let(:movie) { build_stubbed(:movie) }

  describe '.call' do
    before do
      allow(Movie::SubmitWorker)
        .to receive(:perform_async)
        .with(movie.id)

      allow(MoviesQuery)
        .to receive(:call)
        .and_return([movie])

      described_class.call
    end

    it { expect(Movie::SubmitWorker).to have_received(:perform_async).with(movie.id) }
  end
end

# frozen_string_literal: true

RSpec.describe Movie do
  subject(:movie) { create(:movie) }

  it { is_expected.to define_enum_for(:status).with_values([:waiting, :inprogress, :done, :failed]) }
  it { is_expected.to define_enum_for(:priority).with_values([:low, :high, :critical]) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe '#queue_movie' do
    context 'when movie status is waiting' do
      let(:waiting_movie) { create(:movie, status: 0) }

      before do
        allow(described_class::SubmitWorker)
          .to receive(:perform_async)
          .with(waiting_movie.id)
      end

      it { expect(described_class::SubmitWorker).not_to have_received(:perform_async) }
    end
  end
end

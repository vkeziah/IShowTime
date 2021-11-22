# frozen_string_literal: true

RSpec.describe MoviesQuery do
  let(:low_priority_movie) { create(:movie, priority: :low) }
  let(:high_priority_movie) { create(:movie, priority: :high) }

  describe '.call' do
    context 'with default context' do
      before do
        low_priority_movie
        high_priority_movie
      end

      it 'returns all movies by sort order :priority' do
        movies = described_class.call
        expect(movies.first).to eql(high_priority_movie)
      end
    end

    context 'with schedule_date' do
      before do
        create(:movie, priority: :low, schedule_date: Date.today)
        create(:movie, priority: :high, schedule_date: Date.today - 1)
      end

      it 'returns movies by schedule_date' do
        movies = described_class.call(schedule_date: Date.today)
        expect(movies.size).to be(1)
      end
    end
  end
end

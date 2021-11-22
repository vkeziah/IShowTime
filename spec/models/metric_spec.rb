# frozen_string_literal: true

RSpec.describe Metric do
  subject(:metric) { create(:metric) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end

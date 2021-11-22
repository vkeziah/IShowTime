# frozen_string_literal: true

RSpec.describe User do
  subject(:user) { create(:user) }

  it { is_expected.to have_many(:metrics).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:email) }
end

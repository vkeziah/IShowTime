# frozen_string_literal: true

RSpec.describe RequestMetricService do
  let(:service) { described_class.new(start_time, end_time, data) }
  let(:start_time) { Time.now.in_time_zone }
  let(:end_time) { Time.now.in_time_zone }
  let(:env) do
    OpenStruct.new(
      env: {
        'REQUEST_PATH' => 'PATH',
        'REQUEST_METHOD' => 'METHOD',
        'HTTP_AUTHORIZATION' => 'AUTH'
      }
    )
  end

  let(:data) { { headers: env } }

  describe '.call' do
    context 'when request is not belongs to registrations' do
      before do
        allow(service)
          .to receive(:registration_controller?)
          .and_return(false)

        allow(Metric)
          .to receive(:create)

        service.call
      end

      it { expect(Metric).to have_received(:create) }
    end

    context 'when request is belongs to registrations' do
      before do
        allow(service)
          .to receive(:registration_controller?)
          .and_return(true)

        allow(Metric)
          .to receive(:create)

        service.call
      end

      it { expect(Metric).not_to have_received(:create) }
    end
  end
end

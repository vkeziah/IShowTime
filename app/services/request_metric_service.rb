# frozen_string_literal: true

class RequestMetricService
  METRICS_TYPE = 'controller'

  class << self
    def send(start_time, end_time, data)
      new(start_time, end_time, data).call
    end
  end

  def initialize(start_time, end_time, data)
    @start_time = start_time
    @end_time = end_time
    @payload_env = data[:headers].env
  end

  def call
    create_metric unless registration_controller?
  end

  attr_reader :payload_env, :start_time, :end_time

  private

  def create_metric
    Metric.create(
      identifier: METRICS_TYPE,
      url: request_path,
      start_time: start_time,
      end_time: end_time,
      user_id: user_id
    )
  end

  def registration_controller?
    request_path == '/api/v1/users' and request_method == 'POST'
  end

  def user_id
    AuthenticationTokenService.decode(auth_token)
  end

  def request_path
    payload_env['REQUEST_PATH']
  end

  def request_method
    payload_env['REQUEST_METHOD']
  end

  def auth_token
    payload_env['HTTP_AUTHORIZATION']
  end
end

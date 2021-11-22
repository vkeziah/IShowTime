# frozen_string_literal: true

class MetricsQuery
  attr_reader :scope, :params

  def self.call(params = {}, scope = Metric.all)
    new(params, scope).call
  end

  def initialize(params, scope)
    @params = params
    @scope = scope
  end

  def call
    scoped = scope.order(start_time: :desc)
    filter_by_user(scoped, params[:user_id])
  end

  private

  def filter_by_user(scoped, user_id = nil)
    user_id ? scoped.where(user_id: user_id) : scoped
  end
end

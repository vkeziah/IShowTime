# frozen_string_literal: true

class MoviesQuery
  attr_reader :scope, :params

  def self.call(params = {}, scope = Movie.all)
    new(params, scope).call
  end

  def initialize(params, scope)
    @params = params
    @scope = scope
  end

  def call
    scoped = scope.order(priority: :desc)
    filter_by_schedule_date(scoped, params[:schedule_date])
  end

  private

  def filter_by_schedule_date(scoped, schedule_date = nil)
    schedule_date ? scoped.where(schedule_date: schedule_date) : scoped
  end
end

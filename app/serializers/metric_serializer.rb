# frozen_string_literal: true

class MetricSerializer < ActiveModel::Serializer
  attributes :identifier, :url, :started, :finished

  def started
    object.decorate.started
  end

  def finished
    object.decorate.finished
  end
end

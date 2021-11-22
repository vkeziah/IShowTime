# frozen_string_literal: true

class MetricDecorator < ApplicationDecorator
  def started
    object.start_time.in_time_zone.strftime('%m/%d/%y %H:%M:%S %Z')
  end

  def finished
    object.end_time.in_time_zone.strftime('%m/%d/%y %H:%M:%S %Z')
  end
end

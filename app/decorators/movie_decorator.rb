# frozen_string_literal: true

class MovieDecorator < ApplicationDecorator
  def created_at
    object.created_at.in_time_zone.strftime('%m/%d/%y %H:%M:%S %Z')
  end
end

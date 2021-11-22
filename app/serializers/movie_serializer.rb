# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :title, :priority, :status, :created_at

  def created_at
    object.decorate.created_at
  end
end

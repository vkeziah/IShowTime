# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_many :metrics, dependent: :destroy
end

# frozen_string_literal: true

class Planet < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
end

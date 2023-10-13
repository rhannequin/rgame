# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_many :planets, dependent: :destroy

  validates :confirmation_token, length: {maximum: 128}, uniqueness: true
  validates :encrypted_password, presence: true, length: {maximum: 128}
end

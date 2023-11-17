# frozen_string_literal: true

FactoryBot.define do
  factory :metal_mine_upgrade do
    planet
    target_level { 2 }
    ends_at { 1.minute.from_now }

    trait :finished do
      finished { true }
    end

    trait :in_progress do
      finished { false }
    end
  end
end

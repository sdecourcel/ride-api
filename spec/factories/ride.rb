FactoryBot.define do
  factory :ride do
    trait :with_started_status do
      status { "started" }
    end
    trait :with_completed_status do
      status { "completed" }
    end
    trait :with_cancelled_status do
      status { "cancelled" }
    end
  end
end

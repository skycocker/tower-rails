FactoryBot.define do
  factory :user_device do
    user
    sequence(:fcm_token) { |n| "fcm-token-#{n}" }
  end
end

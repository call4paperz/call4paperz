FactoryBot.define do
  factory :vote do
    association :user
    association :proposal
    direction   1
  end
end
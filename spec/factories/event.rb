FactoryBot.define do
  factory :event do
    name        { 'GURU-SP' }
    description { '50th meeting' }
    association :user
    occurs_at   { 1.month.from_now }
  end
end

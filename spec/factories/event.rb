FactoryBot.define do
  factory :event do
    name        'GURU-SP'
    description '50th meeting'
    association :user
    occurs_at   { 1.month.from_now }

    trait :ruby do
      after(:create) do |event| 
        event.tag_list.add("ruby")
        event.save
      end
    end
  end
end
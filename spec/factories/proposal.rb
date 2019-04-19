FactoryBot.define do
  factory :proposal do
    name        'Refactoring'
    description 'Refactoring Ruby'
    association :event
    association :user
  end
end
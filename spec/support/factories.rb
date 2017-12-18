require 'factory_bot'

FactoryBot.define do
  factory :user do
    name     'User'
    email    'example@example.com'
    password '123123'
    confirmed_at (Time.now - 1.day)
  end

  factory :event do
    name        'GURU-SP'
    description '50th meeting'
    association :user
    occurs_at   { 1.month.from_now }
  end

  factory :proposal do
    name        'Refactoring'
    description 'Refactoring Ruby'
    association :event
    association :user
  end

  factory :comment do
    body        'Lorem Ipsum Dolor'
    association :proposal
    association :user
  end

  factory :vote do
    association :user
    association :proposal
    direction   1
  end

  factory :positive_vote, :parent => :vote do
    direction 1
  end

  factory :negative_vote, :parent => :vote do
    direction(-1)
  end
end

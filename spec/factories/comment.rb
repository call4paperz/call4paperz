FactoryBot.define do
  factory :comment do
    body        { 'Lorem Ipsum Dolor' }
    association :proposal
    association :user
  end
end

FactoryBot.define do
  factory :vote do
    association :user
    association :proposal
    direction { 1 }
  end

  factory :positive_vote, parent: :vote do
    direction { 1 }
  end

  factory :negative_vote, parent: :vote do
    direction { -1 }
  end
end

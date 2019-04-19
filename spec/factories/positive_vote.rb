FactoryBot.define do
  factory :positive_vote, :parent => :vote do
    direction 1
  end
end
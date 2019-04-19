FactoryBot.define do
  factory :negative_vote, :parent => :vote do
    direction(-1)
  end
end
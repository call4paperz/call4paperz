FactoryBot.define do
  factory :user do
    name     'User'
    email    'example@example.com'
    password '123123'
    confirmed_at (Time.now - 1.day)
  end
end
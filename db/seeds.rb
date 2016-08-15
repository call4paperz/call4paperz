user = User.find_or_create_by!(email: 'user@call4paperz.com') do |u|
  u.password = '123456'
end

5.times do |i|
  Event.create!(name: "test event #{i}",
                description: "event description #{i}",
                occurs_at: Date.tomorrow,
                user: user)
end

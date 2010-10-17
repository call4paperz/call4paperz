Factory.define(:user) do |f|
  f.name      'User'
  f.email     'example@example.com'
  f.password  '123123'
end

Factory.define(:event) do |f|
  f.name           'GURU-SP'
  f.description    '50th meeting'
  f.association    :user
  f.occurs_at      { 1.month.from_now }
end

Factory.define(:proposal) do |f|
  f.name           'Refactoring'
  f.description    'Refactoring Ruby'
  f.association    :event
  f.association    :user
end

Factory.define(:comment) do |f|
  f.body          'Lorem Ipsum Dolor'
  f.association   :proposal
  f.association   :user
end


Factory.define(:vote) do |f|
  f.association   :user
  f.association   :proposal
  f.direction     1
end

Factory.define(:positive_vote, :parent => :vote) do |f|
  f.direction 1
end

Factory.define(:negative_vote, :parent => :vote) do |f|
  f.direction(-1)
end

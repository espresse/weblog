Factory.define :user do |f|
  f.sequence(:username) { |n| "User #{n}" }
  f.sequence(:email) { |n| "user#{n}@example.com" }
  f.password "secret"
end

Factory.define :post do |f|
  f.sequence(:title) { |n| "Post Title #{n}" }
  f.content "Lorem ipsum" * 400
  f.user { |p| p.association(:user) }
end

Factory.define :comment do |f|
  f.sequence(:content) { |n| "Comment #{n}" }
  f.user { |c| p.association(:user) }
  f.post { |c| c.association(:post) }
end

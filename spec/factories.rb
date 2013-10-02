FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "secret"
  end

  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    content "Lorem ipsum" * 400
    user
    # tag
  end

  factory :comment do
    sequence(:content) { |n| "Comment #{n}" }
    user
    post
  end

  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }
  end

end

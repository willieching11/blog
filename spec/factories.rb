FactoryGirl.define do
  factory :user do |f|
    f.sequence(:name) { |n| "Test#{n} Name"}
    f.sequence(:email) { |n| "test#{n}@test.com" }
    f.password "password"
    f.password_confirmation { |d| d.password }
  end
  #Factory for an associated model
  factory :article do |f|
    f.sequence(:title) { |n| "Article #{n}" }
    f.sequence(:post) { |n| "Post #{n}" }
    f.association :user #will create a user for this task to belong to
    # unless I supply a user in the options hash when I create this user.
  end
end
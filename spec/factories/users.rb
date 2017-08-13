FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "tester-#{n}@mail.example" }
    password 'test-password'
  end
end

FactoryGirl.define do
  factory :event do
    name 'MyString'
    start 3.days.from_now
    place 'MyString'
    description 'MyText'
    user
    calendar
  end
end

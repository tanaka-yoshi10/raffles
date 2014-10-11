# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "MyString"
    start_at "2014-10-11 00:00:19"
    end_at "2014-10-11 00:00:19"
    project nil
  end
end

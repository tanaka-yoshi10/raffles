# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) { |i| "project#{i}" }
    sequence(:code) { |i| "code#{i}" }
    sequence(:category) { |i| "category#{i}" }
  end
end

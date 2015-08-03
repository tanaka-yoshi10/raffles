# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    sequence(:name) { |i| "task#{i}" }
    start_at { rand(1..30).days.from_now}
    end_at { start_at + rand(1..30).hours }
    project nil
  end
end

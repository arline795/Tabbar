FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }
  end
end

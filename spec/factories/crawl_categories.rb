FactoryGirl.define do
  factory :crawl_category do
    association :category
    association :product_crawler
    url { Faker::Internet.url }
  end
end

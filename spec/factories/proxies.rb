FactoryGirl.define do
  factory :proxy do
    ip { Faker::Internet.ip_v4_address }
    port { rand(65_535).to_s }
    user nil
    password nil
    user_agent { Faker::Lorem.sentence }
  end
end

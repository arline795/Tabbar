FactoryGirl.define do
  factory :product_crawler do
    location 'US'
    product_link_css '.product_link_css'
    title_css '.title'
    price_css '.price'
    description_css '.description'
    user
  end
end

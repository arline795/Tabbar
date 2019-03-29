FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@factory.com"
  end

  sequence :username do |n|
    "username#{n}"
  end

  sequence :account_name do |n|
    "account#{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :title do |n|
    "title#{n}"
  end

  sequence :instagram_token do |n|
    "instagram_token#{n}"
  end

  sequence :instagram_username do |n|
    "instagram_username#{n}"
  end

  sequence :uuid do |n|
    "uuid#{n}"
  end

  sequence :uid do |n|
    "uuid#{n}"
  end

  factory :tagged_product do
    product_id Faker::Number.number(2)
    media_id Faker::Number.number(2)
    collaboration
    approved true
  end

  factory :product do
    title { Faker::Lorem.characters(10) }
    price Faker::Number.number(2)
    description Faker::Lorem.sentence
    redirect_url { "https://example.com/#{Faker::Number.number(10)}" }
    uuid
    location do
      %w(AD AF AG AI AL AQ AR AS AT AU AW AX AZ BA BB BE BG BL BM
         BN BO BQ BQ BR BS BV BW BY BZ CA CC CH CK CL CN CO CR CU CW
         CX CY CZ DE DK DM DO EC EE EG ES FI FJ FK FM FO FR GB GD GF
         GG GH GI GL GP GR GS GT GU HK HM HN HR HT HU ID IE IL IM IN
         IO IR IS IT JE JP KG KI KN KP KR KY KZ LA LB LC LI LK LR LT
         LU LV MC ME MF MH MN MP MQ MS MT MU MX MY MZ NA NF NG NI NL
         NO NP NR NU NZ OM PA PE PH PK PL PM PN PR PS PT PW PY QA RE
         RO RS RU SA SB SC SE SG SH SI SJ SK SM SO SR SV SX SY TC TF
         TH TK TL TR TT TW UA UM US UY UZ VA VC VE VG VI VN WS YE YT
         ZA ZW).sample
    end

    user

    after(:create) do |product|
      create(:product_image, product: product)
    end
  end

  factory :product_image do
    product_image File.open("#{Rails.root}/spec/fixtures/image.jpg")
    cropped_image File.open("#{Rails.root}/spec/fixtures/image.jpg")

    after(:create) do |product_image|
      product_image.update(direct_url: product_image.product_image.url)
    end
  end

  factory :relationship do
    following_id Faker::Number.number(2)
  end

  factory :media do
    user
    caption { "out-cap #{Faker::Lorem.word}" }
    media_image File.open("#{Rails.root}/spec/fixtures/image.jpg")
  end

  factory :image_of_interest do
    user
    image File.open("#{Rails.root}/spec/fixtures/image.jpg")
  end

  factory :detected_product do
    image_of_interest
    image File.open("#{Rails.root}/spec/fixtures/image.jpg")
    product_coordinate { [1, 1] }
  end

  factory :collaboration do
    association :requester, factory: :user
    association :receiver, factory: :user
  end

  factory :payment do
    association :sender, factory: :user
    association :receiver, factory: :user
    amount_in_cents Faker::Number.number(4)
    token Faker::Number.number(10)
  end

  factory :user do
    username
    email
    first_name             Faker::Name.first_name
    last_name              Faker::Name.last_name
    password               Faker::Internet.password(8)
    password_confirmation { |user| user.password }
    description           Faker::Lorem.sentence
    instagram_token
    roles_mask           { User.mask_for(:regular) }
    instagram_username
    set_up_completed { true }
    uuid
    uid
    country do
      %w(AD AF AG AI AL AQ AR AS AT AU AW AX AZ BA BB BE BG BL BM
         BN BO BQ BQ BR BS BV BW BY BZ CA CC CH CK CL CN CO CR CU CW
         CX CY CZ DE DK DM DO EC EE EG ES FI FJ FK FM FO FR GB GD GF
         GG GH GI GL GP GR GS GT GU HK HM HN HR HT HU ID IE IL IM IN
         IO IR IS IT JE JP KG KI KN KP KR KY KZ LA LB LC LI LK LR LT
         LU LV MC ME MF MH MN MP MQ MS MT MU MX MY MZ NA NF NG NI NL
         NO NP NR NU NZ OM PA PE PH PK PL PM PN PR PS PT PW PY QA RE
         RO RS RU SA SB SC SE SG SH SI SJ SK SM SO SR SV SX SY TC TF
         TH TK TL TR TT TW UA UM US UY UZ VA VC VE VG VI VN WS YE YT
         ZA ZW).sample
    end

    trait :regular do
      roles [:regular]
    end

    trait :influencer do
      roles [:influencer]
    end

    trait :brand do
      roles [:brand]
    end

    trait :admin do
      roles [:admin]
    end
  end

  # factory :admin do
  #   username
  #   email
  #   roles_mask           { User.mask_for(:admin) }
  #   password Faker::Internet.password(8)
  #   password_confirmation { |admin| admin.password }
  #   activated true
  #   description Faker::Lorem.sentence
  #   # activated_at "<%= Time.zone.now %>"
  # end

  factory :webhose_crawler do
    user
  end

  factory :webhose_category do
    category
    query Faker::Lorem.word
  end

  factory :commission_factory_importer do
    user
    csv File.open("#{Rails.root}/spec/fixtures/commission_factory_import.csv")
  end

  factory :user_category_product do
    product
    user_category
  end

  factory :user_category do
    user
    category
  end

  factory :commission_factory_category do
    category
    query Faker::Lorem.word
  end
end

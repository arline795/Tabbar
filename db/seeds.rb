User.create!(
  username:  'user_01',
  first_name: 'user_01',
  last_name: 'user_01',
  email: 'admin@taddar.com',
  password: 'taddar123jk',
  password_confirmation: 'taddar123jk',
  country: 'AU',
  admin: true,
  header_image: File.new("#{Rails.root}/app/assets/images/seeds/header/header_01.jpg")
)

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Sizes
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Sizes
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Sizes

xsmall_to_xlarge = %w(XXSmall XSmall Small Medium Large XLarge XXLarge Other)
not_applicable = ['n/a']
mens_sizes_24_44_xsmall_to_xlarge = %w(24 26 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 42 44 XSmall Small Medium Large XLarge XXLarge Other)
sizes_shoes = %w(3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 Other)
suit_sizes = ['Chest 32 inch', 'Chest 34 inch', 'Chest 36 inch', 'Chest 38 inch', 'Chest 40 inch',
              'Chest 42 inch', 'Chest 44 inch', 'Chest 46 inch', 'Chest 48 inch', 'Chest 50 inch']

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Men Categories
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Men Categories
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Men Categories
Category.create(name: 'Men')

Category.create(name: 'Accessories', ancestry: Category.find_by(name: 'Men').id)
not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Activewear', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Bags', ancestry: Category.find_by(name: 'Men').id)
not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Blazers', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Caps & Hats', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Grooming', ancestry: Category.find_by(name: 'Men').id)
not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Hoodies & Sweatshirts', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jackets & Coats', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jeans', ancestry: Category.find_by(name: 'Men').id)
mens_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jewellery', ancestry: Category.find_by(name: 'Men').id)
not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jumpers & Cardigans', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Polo Shirts', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shirts', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shoes, Boots, & Trainers', ancestry: Category.find_by(name: 'Men').id)
sizes_shoes.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shorts', ancestry: Category.find_by(name: 'Men').id)
mens_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Suits', ancestry: Category.find_by(name: 'Men').id)
suit_sizes.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Sunglasses', ancestry: Category.find_by(name: 'Men').id)
not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Swimwear', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Trousers & Chinos', ancestry: Category.find_by(name: 'Men').id)
mens_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'T-Shirts & Vests', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Underwear & Socks', ancestry: Category.find_by(name: 'Men').id)
xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories

Category.create(name: 'Women')

women_xsmall_to_xlarge = %w(XXSmall XSmall Small Medium Large XLarge XXLarge Other)
women_not_applicable = ['n/a']
women_2_to_30 = %w(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 Other)
women_2_to_30_small_to_xlarge = %w(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 XXSmall XSmall Small Medium Large XLarge XXLarge Other)
women_sizes_24_44_xsmall_to_xlarge = %w(24 26 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 42 44 XSmall Small Medium Large XLarge XXLarge Other)
women_sizes_shoes = %w(3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 Other)

Category.create(name: 'Accessories', ancestry: Category.find_by(name: 'Women').id)
women_not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Activewear', ancestry: Category.find_by(name: 'Women').id)
women_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Tops', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Bags & Purses', ancestry: Category.find_by(name: 'Women').id)
women_not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Beauty', ancestry: Category.find_by(name: 'Women').id)
women_not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Coats & Jackets', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Dresses', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Hoodies & Sweatshirts', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jeans', ancestry: Category.find_by(name: 'Women').id)
women_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jewellery & Watches', ancestry: Category.find_by(name: 'Women').id)
women_not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jumpers & Cardigans', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Jumpsuits & Playsuits', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Lingerie', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30_small_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shirts & Blouses', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shoes', ancestry: Category.find_by(name: 'Women').id)
women_sizes_shoes.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Shorts', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Skirts', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Socks & Tights', ancestry: Category.find_by(name: 'Women').id)

Category.create(name: 'Sunglasses', ancestry: Category.find_by(name: 'Women').id)
women_not_applicable.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Swimwear & Beachwear', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'T-Shirts & Vests', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Tops', ancestry: Category.find_by(name: 'Women').id)
women_2_to_30_small_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Trousers & Leggings', ancestry: Category.find_by(name: 'Women').id)
women_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

Category.create(name: 'Workwear Suits', ancestry: Category.find_by(name: 'Women').id)
women_sizes_24_44_xsmall_to_xlarge.each { |size| Size.create(title: size, category: Category.last) }

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories End
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories End
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Woemn Categories End

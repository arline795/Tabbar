namespace :db do
  task cleanup_product_images: [:environment] do
    ProductImage.where(product_id: nil).destroy_all
  end

  task setup_categories: :environment do
    Category.destroy_all

    categories_hash = YAML.load_file(Rails.root.join('config', 'categories.yml'))
    categories_hash.each do |root, descendants|
      root = Category.create(name: root)
      descendants.each do |parent, children|
        parent = Category.create(name: parent, parent: root)
        children.each do |child|
          Category.create(name: child, parent: parent)
        end
      end
    end
  end

  task setup_proxies: :environment do
    Proxy.destroy_all

    YAML.load_file(Rails.root.join('config', 'proxies.yml')).each do |data|
      Proxy.create!(data)
    end
  end
end

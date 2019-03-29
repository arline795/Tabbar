namespace :instagram do
  task check_liked_media: [:environment] do
    User.where.not(instagram_token: nil).find_each do |user|
      begin
        liked_media = Instagram.client(access_token: user.instagram_token).user_liked_media
        Product.joins(tagged_products: :media)
               .where(medias: { instagram_media_id: liked_media.map(&:id) })
               .where.not(id: user.liked_products.pluck(:product_id)).find_each do |product|
          LikedProduct.create!(user: user, product: product)
        end
      rescue Instagram::BadRequest => e
        p e
      end
    end
  end
end

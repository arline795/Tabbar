every :hour do
  rake 'instagram:check_liked_media'
  rake 'db:cleanup_product_images'
end

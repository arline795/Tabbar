json.call(user, :id, :username)
json.image_url user.avatar(:large)
json.user_outfits_path user_outfits_path(user)

json.array! @user_categories do |uc|
  json.call uc.category, :id, :capitalized_name
  json.call uc, :products_count
end

crumb :home do |user|
  link 'Home', products_users_path(user)
end

crumb :category do |user, category|
  link category.name, category_path(user, category)

  if category.parent
    parent :category, user, category.parent
  else
    parent :home, user
  end
end

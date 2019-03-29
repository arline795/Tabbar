namespace :oneoff do
  task reload_users: [:environment] do
    User.find_each(&:save)
  end
end

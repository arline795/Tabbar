if Rails.env == 'production'
  Bugsnag.configure do |config|
    config.api_key = '553d48a129d60ed7361a30579d240898'
  end
end

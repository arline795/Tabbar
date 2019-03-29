require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/poltergeist'
require 'support/controller_helpers'
require 'phantomjs'
require 'support/authentication_helpers'
require 'support/url_helpers'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include Capybara::DSL
  config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, type: :controller

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:example) do |example|
    DatabaseCleaner.strategy = example.metadata[:type] == :feature ? :truncation : :transaction
    DatabaseCleaner.cleaning { example.run }
  end

  config.before(:each, with_default_user: true) do
    @default_user = create(:user)
    create(:media, user: @default_user)
    create(:product, user: @default_user)
  end

  config.before(:suite) do
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
                                      js_errors: false,
                                      phantomjs_options: ['--ignore-ssl-errors=yes', '--ssl-protocol=any'],
                                      debug: false,
                                      timeout: 500,
                                      phantomjs: File.absolute_path(Phantomjs.path)
                                    })
end
Capybara.javascript_driver = :poltergeist
Capybara.server_port = 3001

require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end

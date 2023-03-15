# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

require 'factory_bot_rails'
require 'faker'
require 'rails_helper'
require 'rspec-rails'
require 'capybara/rails'
require 'vcr'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
end


Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('window-size=2560x2560')
  options.add_argument('disable-dev-shm-usage') if ENV['CI']

  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options])
end

Capybara.javascript_driver = :headless_chrome

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end

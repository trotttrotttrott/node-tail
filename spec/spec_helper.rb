require 'sinatra'
require 'rack/test'
require 'rspec'
require 'capybara/rspec'

require_relative '../app'

# setup test environment
App.environment = :test

Dir[File.expand_path("../../config/initializers/**/*.rb", __FILE__)].each { |file| require file }
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |file| require file }

enable :raise_errors, :dump_errors
disable :logging, :run, :show_exceptions

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.include MarqetaAPIHelper
  config.include FormHelper
  config.include LoginHelper

  config.before do
    reset_api_stub
    App.set_marqeta_api(api_stub)
  end
end

def app
 App
end

Capybara.app = App

config_hash = {
  "PROTOCOL" => "http",
  "MARQETA_HOST" => "fakedmarqeta.com",
  "API_HOST" => "fakedmarqeta.com",
  "MARQETA_JAMBA_LANDING_PAGE" => "dashboard",
  "ENABLE_CARDHOLDER_REGISTRATION" => "true"
}

config_hash.each { |key, value| ENV[key] = value }

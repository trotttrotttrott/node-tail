require 'sinatra'
require 'rack/test'
require 'rspec'
require 'capybara/rspec'

require_relative '../app'

# setup test environment
App.environment = :test

enable :raise_errors, :dump_errors
disable :logging, :run, :show_exceptions

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
end

def app
 App
end

Capybara.app = App

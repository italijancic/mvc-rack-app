# frozen_string_literal: true

require 'rack/test'
require 'debug'
require 'json'
require_relative '../config/loader'
require_relative 'support/test_db_helper'
require_relative 'support/authentication_helper'

Loader.load(env: :test)

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include TestDbHelper
  config.before(:each) do
    seed_test_data
  end
  config.after(:each) do
    reset_test_db
  end
end

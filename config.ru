# frozen_string_literal: true

require 'rack'
require 'rack/contrib'
require 'debug'
require_relative 'config/loader'

Loader.load(env: ENV['RACK_ENV']&.to_sym || :development)

use Rack::Reloader, 0
run Application.new

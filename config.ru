# frozen_string_literal: true

require 'rack'
require 'debug'
# binding.irb -> cmd to add a break point in the code
require_relative 'config/loader'

Loader.load(env: ENV['RACK_ENV']&.to_sym || :development)

run Application.new

# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env')

require 'pry-byebug'
require_relative 'config/loader'

Loader.load(env: ENV['RACK_ENV']&.to_sym || :development)

run Application.new

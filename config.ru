# frozen_string_literal: true

require 'rack'
require 'rack/contrib'
# require 'debug'
# binding.irb -> cmd to add a break point in the code
require_relative 'config/loader'

Loader.load(env: ENV['RACK_ENV']&.to_sym || :development)

app = Rack::Builder.new do
  use Rack::Reloader, 0
  use Rack::ETag
  use Rack::Deflater
  use Rack::ConditionalGet
  use Rack::Static, {
    root: '.',
    urls: ['/public'],
    headers_rules: [
      [:all, { 'cache-control' => 'public, max-age=86400' }]
    ]
  }
  run Application.new
end

run app

# frozen_string_literal: true

class Application
  def initialize
    @app = build_app
  end

  def call(env)
    @app.call(env)
  end

  def handle_request(env)
    Router.new(Rack::Request.new(env)).route
  end

  private

  def build_app
    Rack::Builder.new do
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
      # Use separate middleware for basic authentication
      if ENV['BASIC_USER_NM'] && ENV['BASIC_PASSWORD']
        use BasicAuthMiddleware, ENV['BASIC_USER_NM'], ENV['BASIC_PASSWORD']
      end

      run ->(env) { Application.new.handle_request(env) }
    end
  end
end

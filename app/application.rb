# frozen_string_literal: true

class Application
  def call(env)
    request = Rack::Request.new(env)
    serve_request(request)
  end
end

def serve_request(request)
  Router.new(request).route!
end

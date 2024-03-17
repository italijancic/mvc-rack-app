# frozen_string_literal: true

class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def index
    build_response <<~HTML
      <html>
        <head><title>A Rack Demo</title></head>
        <body>
          <h1>This is the root page</h1>
          <p>Hello from a controller!</p>
        </body>
      </html>
    HTML
  end

  def not_found(msg = '<h1>HTPP 404 Page not found :( !</h1>')
    [404, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  private

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end

  def redirect_to(uri)
    [302, { 'Location' => uri }, []]
  end

  def params
    request.params
  end
end

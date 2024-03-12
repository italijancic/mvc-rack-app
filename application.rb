# frozen_string_literal: true

class Application
  def call(_env)
    ['200', { 'Content-Type' => 'text/html' }, ['Hello from rack with autoreload']]
  end
end

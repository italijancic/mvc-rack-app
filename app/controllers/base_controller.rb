# frozen_string_literal: true

require 'erb'

class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def index
    build_response(render_template)
  end

  def not_found(msg = '<h1>HTPP 404 Page not found :( !</h1>')
    [404, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  private

  def render_partial(file_name)
    partial_path = partial_file_path(file_name)
    if File.exist?(partial_path)
      puts "Rendering template file #{partial_path}"
      render_erb_file(partial_path)
    else
      "ERROR: no available template file #{partial_path}"
    end
  end

  def partial_file_path(file_name)
    File.expand_path(File.join('../../views', "#{resource}/#{file_name}.html.erb"), __FILE__)
  end

  def render_template
    if File.exist?(template_file_path)
      puts "Rendering template file #{template_file_path}"
      render_erb_file(template_file_path)
    else
      "ERROR: no available template file #{template_file}"
    end
  end

  def template_file_path
    File.expand_path(File.join('../../views', "#{resource}/#{action}.html.erb"), __FILE__)
  end

  def render_erb_file(file_path)
    raw = File.read(file_path)
    ERB.new(raw).result(binding)
  end

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end

  def redirect_to(uri)
    [302, { 'Location' => uri }, []]
  end

  def params
    request.params
  end

  def resource
    request.params[:resource].to_s
  end

  def action
    request.params[:action].to_s
  end
end

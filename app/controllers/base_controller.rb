# frozen_string_literal: true

class BaseController
  attr_reader :request, :resource, :action

  def initialize(request)
    @request = request
    @resource = request.params[:resource].to_s
    @action = request.params[:action].to_s
  end

  def index
    build_response(render_template)
  end

  def not_found(msg = '<h1>HTPP 404 Page not found :( !</h1>')
    [404, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  private

  def render_template
    template_file = File.join(resource, "#{action}.html.erb")
    file_path = template_file_path_for(template_file)

    if File.exist?(file_path)
      puts "Rendering template file #{template_file}"
      render_erb_file(file_path)
    else
      "ERROR: no available template file #{template_file}"
    end
  end

  def template_file_path_for(file_name)
    File.expand_path(File.join('../../views', file_name), __FILE__)
  end

  def render_erb_file(file_path)
    File.read(file_path)
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
end

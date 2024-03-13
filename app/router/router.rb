# frozen_string_literal: true

# Routes to handle
# GET    /resource           # index  - get a list of the resources
# GET    /resource/:id       # show   - get a specific resource
# GET    /resource/new       # new    - get an HTML page with a form
# POST   /resource           # create - create a new resource

class Router
  def initialize(request)
    @request = request
  end

  def route!
    # Get controller class name
    klass = controller_class
    unless klass.nil?
      add_route_info_to_request_params!

      # Instantiate a new object of controller class
      controller = klass.new(@request)
      # Get accion name to call
      action = route_info[:action]

      if controller.respond_to?(action)
        p "\nRouting to #{klass}##{action}"
        return controller.public_send(action)
      else
        # Action not implemented
        not_found
      end
    end
    # Controller not implemented
    not_found
  end

  private

  def not_found(msg = 'Not Found')
    [404, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  def add_route_info_to_request_params!
    @request.params.merge!(route_info)
  end

  def route_info
    @route_info ||= begin
      resource = path_fragments[0] || 'base'
      method, id, action = find_id_and_action(path_fragments[1])
      { method:, resource:, action:, id: }
    end
  end

  def find_id_and_action(fragment)
    case fragment
    when 'new'
      [http_method, nil, :new]
    when nil
      action = @request.get? ? :index : :create
      [http_method, nil, action]
    else
      [http_method, fragment, :show]
    end
  end

  def path_fragments
    @path_fragments ||= @request.path.split('/').reject(&:empty?)
  end

  def http_method
    @request.env['REQUEST_METHOD']
  end

  # Get the proper controller
  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get(controller_name)
  rescue NameError
    nil
  end
end

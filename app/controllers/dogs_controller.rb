# frozen_string_literal: true

class DogsController < BaseController
  # GET /dogs
  #
  def index
    @title = 'So many dogs'
    @dogs = Dog.all
    build_response(render_template)
  end

  # GET /dogs/:id
  #
  def show
    @dog = Dog.find(id)
    @title = "#{@dog.name}'s page"
    build_response(render_template)
  end

  # GET /dogs/new
  #
  def new
    @title = 'More dogs please'
    build_response(render_template)
  end

  # POST /dogs
  # not implemented for now
  #
  def create
    binding.irb
    dog = Dog.new(name: params['dog']['name'])
    dog.save
    redirect_to "/dogs/#{dog.id}"
  end

  # DELETE /dogs/:id
  def delete
    dog = Dog.find(id)
    if dog.nil?
      puts "[ERROR][Dog#delete]: couldn't find Dog_id: #{@dog.id}"
    else
      dog.delete
      puts "[INFO][Dog#delete]: Delete Dog_id: #{@dog.id}, not implemented yet!"
    end
    redirect_to '/dogs'
  end

  private

  def id
    params[:id].to_i
  end
end

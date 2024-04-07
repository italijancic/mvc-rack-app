# frozen_string_literal: true

class JsonDogsController < JsonBaseController
  # GET /dogs
  #
  def index
    @dogs = Dog.all
    if @dogs.empty?
      not_found
    else
      json_response(ObjectSerializer.serialize_each(@dogs))
    end
  end

  # GET /dogs/:id
  #
  def show
    @dog = Dog.find(id)
    if @dog.nil?
      not_found
    else
      json_response(ObjectSerializer.serialize(@dog))
    end
  end

  # POST /dogs
  # not implemented for now
  #
  def create
    dog = Dog.new(name: params['dog']['name'])
    dog.save
    # Build success json response
    # redirect_to "/dogs/#{dog.id}"
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
    # Build success json response
    # redirect_to '/dogs'
  end

  private

  def id
    params[:id].to_i
  end
end

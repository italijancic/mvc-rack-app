# frozen_string_literal: true

class JsonDogsController < JsonBaseController
  # GET /jsondogs
  #
  def index
    @dogs = Dog.all
    if @dogs.empty?
      not_found
    else
      json_response(ObjectSerializer.serialize_each(@dogs))
    end
  end

  # GET /jsondogs/:id
  #
  def show
    @dog = Dog.find(id)
    if @dog.nil?
      not_found
    else
      json_response(ObjectSerializer.serialize(@dog))
    end
  end

  # POST /jsondogs
  #
  def create
    data = JSON.parse(request.body.read)
    dog = Dog.new(name: data['name'])
    dog.save
    json_response({ message: "Dog #{data['name']} was created" })
  end

  # DELETE /jsondogs/:id
  def delete
    dog = Dog.find(id)
    if dog.nil?
      json_response({ message: "Dog #{id} not found" }, status: 404)
    else
      dog.delete
      json_response({ message: "Dog #{id} was delete" })
    end
  end

  private

  def id
    params[:id].to_i
  end
end

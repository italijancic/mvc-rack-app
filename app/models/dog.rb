# frozen_string_literal: true

require_relative './base_model'

class Dog < BaseModel
  attr_accessor :id, :name

  def initialize(id: nil, name: nil)
    @id = id
    @name = name
  end
end

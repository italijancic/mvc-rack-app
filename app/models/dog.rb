# frozen_string_literal: true

class Dog < BaseModel
  attr_accessor :id, :name

  def initialize(id: nil, name: nil)
    @id = id
    @name = name
  end
end

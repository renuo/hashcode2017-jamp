# frozen_string_literal: true
class Endpoint
  attr_accessor :id, :connections, :requests

  def initialize(id)
    @id = id
    @requests = []
    @connections = []
  end
end

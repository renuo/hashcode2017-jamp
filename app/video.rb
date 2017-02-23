# frozen_string_literal: true
class Video
  attr_accessor :id, :size

  def initialize(id, size)
    @id = id
    @size = size
  end
end

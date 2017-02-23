# frozen_string_literal: true
class CacheServer
  attr_accessor :max_capacity, :id, :is_data_center, :videos, :available_space

  def initialize(id, max_capacity, is_data_center = false)
    @id = id
    @max_capacity = max_capacity
    @is_data_center = is_data_center
    @videos = []
    @available_space = max_capacity
  end

  def to_s
    ([id.to_s] + @videos.map(&:id)).join(' ')
  end

  def is_data_center?
    is_data_center
  end

  # TODO: add function to calc
  def available_space
    if is_data_center?
      99_999_999
    else
      @available_space
    end
  end
end

# frozen_string_literal: true
require_relative 'solution.rb'

class RandomAlgorithm
  attr_accessor :world

  def initialize(world)
    @world = world
  end

  def solve
    videos = @world.data_center.videos
    smallest_video = videos.min_by(&:size)

    @world.cache_servers.each do |cache_server|
      while cache_server.available_space >= smallest_video.size
        random_video = videos.sample
        if cache_server.available_space >= random_video.size
          cache_server.videos = cache_server.videos | [random_video]
          cache_server.available_space -= random_video.size
        end
      end
    end

    Solution.new(@world.cache_servers)
  end
end

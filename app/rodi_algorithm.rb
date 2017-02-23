# frozen_string_literal: true
require_relative 'solution.rb'

class RodiAlgorithm
  attr_accessor :world

  def available_space(cache_server)
    return Float::INFINITY if cache_server.is_data_center?
    cache_server.available_space
  end

  def put(cache_server, video)
    cache_server.available_space -= video.size
    cache_server.videos << video
  end

  def initialize(world)
    @world = world
  end

  def solve
    world.requests.each do |request|
      video = request.video
      next if video.size > world.cache_servers[0].max_capacity
      request.endpoint.connections.each do |connection|
        cache_server = connection.cache_server
        break if cache_server.videos.include?(video)

        if available_space(cache_server) >= video.size
          put(cache_server, video)
          break
        end
      end
    end

    world.cache_servers.each do |cache_server|
      puts "cache server #{cache_server.id} has #{cache_server.available_space}MB free"
    end

    Solution.new(world.cache_servers)
  end
end

# frozen_string_literal: true
require_relative 'solution.rb'

class BasicAlgorithm
  attr_accessor :world

  def puts(whatever)
  end

  def available_space(cache_server)
    return Float::INFINITY if cache_server.is_data_center?
    cache_server.available_space
  end

  def put(cache_server, video)
    puts "putting video #{video.id} in #{cache_server.id}"
    cache_server.available_space -= video.size
    cache_server.videos << video
  end

  def initialize(world)
    @world = world
  end

  def solve
    puts "start solving #{world.requests.count} requests"
    world.requests.each do |request|
      video = request.video
      puts "check if #{video.id}:#{video.size} fits into #{world.cache_servers[0].max_capacity}"
      next if video.size > world.cache_servers[0].max_capacity
      puts "it fits. checking endpoint connections #{request.endpoint.connections.count}"
      request.endpoint.connections.each do |connection|
        cache_server = connection.cache_server
        puts "check: #{connection}"
        break if cache_server.videos.include?(video)
        puts "check available space, #{available_space(cache_server)}, #{video.size}"

        if available_space(cache_server) >= video.size
          put(cache_server, video)
          break
        end
      end
    end

    Solution.new(world.cache_servers)
  end
end

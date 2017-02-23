# frozen_string_literal: true
require_relative './world.rb'
require_relative './video.rb'
require_relative './endpoint.rb'
require_relative './request.rb'
require_relative './connection.rb'
require_relative './cache_server.rb'

class FileReader
  def initialize(file_path)
    @file = File.read(file_path)
  end

  def puts(whatever)
  end

  def world
    lines = @file.split(/\n/)
    first_line = lines[0].split
    videos_count = first_line[0].to_i
    endpoints_count = first_line[1].to_i
    requests_count = first_line[2].to_i
    cache_servers_count = first_line[3].to_i
    cache_servers_capacity = first_line[4].to_i
    videos_sizes = lines[1].split
    videos = Array.new(videos_count) do |i|
      Video.new(i, videos_sizes[i].to_i)
    end
    data_center = CacheServer.new(nil, nil, true)
    data_center.videos = videos

    cache_servers = Array.new(cache_servers_count) do |c|
      CacheServer.new(c, cache_servers_capacity)
    end

    line_count = 1
    endpoints = Array.new(endpoints_count) do |i|
      line_count += 1
      puts "parsing endpoint #{i}: #{lines[line_count]}"
      endpoint_line = lines[line_count].split
      endpoint = Endpoint.new(i)
      connections = []
      endpoint_line[1].to_i.times do |_j| #
        line_count += 1
        puts "parsing line #{line_count}: #{lines[line_count]}"
        connection_line = lines[line_count].split
        cache_server = cache_servers[connection_line[0].to_i]
        latency = connection_line[0].to_i
        puts "cache_server:#{cache_server.id}"
        puts "endpoint:#{endpoint.id}"
        connection = Connection.new(latency, cache_server, endpoint)
        puts "creating a connection: #{connection}"
        connections << connection
      end
      connections << Connection.new(endpoint_line[0].to_i, data_center, endpoint)
      endpoint.connections = connections
      endpoint
    end

    requests_count.times do |_r|
      line_count += 1

      puts "parsing request line: #{lines[line_count]}"
      request_line = lines[line_count].split
      video = videos[request_line[0].to_i]
      endpoint = endpoints[request_line[1].to_i]
      request = Request.new(video, endpoint, request_line[2].to_i)
      endpoint.requests << request
    end
    World.new(data_center, cache_servers, endpoints)
  end

  def fake_world
    data_center = CacheServer.new(nil, nil, true)
    videos = []
    videos << Video.new(0, 50)
    videos << Video.new(1, 50)
    videos << Video.new(2, 80)
    videos << Video.new(3, 30)
    videos << Video.new(3, 110)
    data_center.videos = videos
    cache_servers = []
    cache_servers << CacheServer.new(0, 100)
    cache_servers << CacheServer.new(1, 100)
    cache_servers << CacheServer.new(2, 100)
    endpoints = []

    endpoint0 = Endpoint.new(0)
    connections = []
    connections << Connection.new(100, cache_servers[0], endpoint0)
    connections << Connection.new(200, cache_servers[1], endpoint0)
    connections << Connection.new(200, cache_servers[2], endpoint0)
    connections << Connection.new(1000, data_center, endpoint0)
    endpoint0.connections = connections

    requests = []
    requests << Request.new(videos[3], endpoint0, 1500)
    requests << Request.new(videos[4], endpoint0, 500)
    requests << Request.new(videos[1], endpoint0, 1000)
    endpoint0.requests = requests
    endpoints << endpoint0

    endpoint1 = Endpoint.new(1)
    connections = [Connection.new(500, data_center, endpoint1)]
    endpoint1.connections = connections
    requests = []
    requests << Request.new(videos[0], endpoint1, 1000)
    endpoint1.requests = requests
    endpoints << endpoint1
    World.new(data_center, cache_servers, endpoints)
  end
end

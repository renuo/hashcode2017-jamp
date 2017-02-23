# frozen_string_literal: true
class World
  attr_accessor :data_center, :cache_servers, :endpoints, :videos, :requests

  def initialize(data_center, cache_servers, endpoints)
    @data_center = data_center
    @cache_servers = cache_servers
    @endpoints = endpoints

    @videos = @data_center.videos.sort_by(&:size)
    @requests = @endpoints.map(&:requests).flatten.sort_by { |v| -v.amount }
    @endpoints.each do |endpoint|
      endpoint.connections = endpoint.connections.sort_by(&:latency)
    end
  end

  def self.example
    data_center = CacheServer.new(-1, 99_999_999, true)
    data_center.videos = [Video.new(0, 50), Video.new(1, 50), Video.new(2, 80), Video.new(3, 30), Video.new(4, 110)]

    cache_servers = [CacheServer.new(0, 100), CacheServer.new(1, 100), CacheServer.new(2, 100)]

    endpoint_0 = Endpoint.new(0)
    endpoint_0.connections << Connection.new(100, cache_servers[0], endpoint_0)
    endpoint_0.connections << Connection.new(200, cache_servers[2], endpoint_0)
    endpoint_0.connections << Connection.new(200, cache_servers[1], endpoint_0)

    endpoint_1 = Endpoint.new(1)
    endpoints = [endpoint_0, endpoint_1]

    World.new(data_center, cache_servers, endpoints)
  end
end

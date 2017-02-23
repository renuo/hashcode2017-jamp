# frozen_string_literal: true
require_relative '../app/basic_algorithm.rb'
require_relative '../app/cache_server.rb'
require_relative '../app/endpoint.rb'
require_relative '../app/world.rb'
require_relative '../app/video.rb'
require_relative '../app/request.rb'
require_relative '../app/connection.rb'

RSpec.describe BasicAlgorithm do
  before do
    data_center = CacheServer.new(3, 100, true)
    @videos = [Video.new(0, 50), Video.new(1, 50), Video.new(2, 80), Video.new(3, 30), Video.new(4, 110)]
    data_center.videos = @videos

    cache_servers = [CacheServer.new(0, 100), CacheServer.new(1, 100), CacheServer.new(2, 100)]

    endpoint1 = Endpoint.new(0)
    endpoint2 = Endpoint.new(1)

    requests = [Request.new(@videos[3], endpoint1, 1500), Request.new(@videos[0], endpoint2, 1000), Request.new(@videos[1], endpoint1, 1000), Request.new(@videos[4], endpoint1, 500)]

    endpoint1.requests = [requests[0], requests[2], requests[3]]
    endpoint2.requests = [requests[1]]

    # (latency, cache_server, endpoint)
    endpoint1.connections = [Connection.new(100, cache_servers[0], endpoint1), Connection.new(200, cache_servers[1], endpoint1), Connection.new(200, cache_servers[2], endpoint1)]
    endpoint2.connections = [Connection.new(5000, data_center, endpoint2)]

    endpoints = [endpoint1, endpoint2]

    @world = World.new(data_center, cache_servers, endpoints)
  end

  it 'returns a list with 4 cache_server' do
    expect(BasicAlgorithm.new(@world).solve.cache_servers.count).to eq(3)
  end

  it 'returns cache_server 0 with 2 videos' do
    expect(BasicAlgorithm.new(@world).solve.cache_servers[0].videos).to eq([@videos[3], @videos[1]])
  end

  it 'returns cache_server 0 available_space to be ' do
    expect(BasicAlgorithm.new(@world).solve.cache_servers[0].available_space).to eq(20)
  end

  it 'returns cache_server 1 & 2 to be empty' do
    expect(BasicAlgorithm.new(@world).solve.cache_servers[1].videos).to eq([])
    expect(BasicAlgorithm.new(@world).solve.cache_servers[2].videos).to eq([])
  end

  it 'returns cache_server 1 & 2 available_space to be 100' do
    expect(BasicAlgorithm.new(@world).solve.cache_servers[1].available_space).to eq(100)
    expect(BasicAlgorithm.new(@world).solve.cache_servers[2].available_space).to eq(100)
  end
end

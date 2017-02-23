# frozen_string_literal: true
require_relative '../app/cache_server.rb'

RSpec.describe CacheServer do
  it 'works' do
    cache_server = CacheServer.new(10, 100)
    expect(cache_server.id).to eq(10)
    expect(cache_server.max_capacity).to eq(100)
  end

  it '#to_s' do
    cache_server = CacheServer.new(42, 100)
    cache_server.videos = [double(:video, id: 1), double(:video, id: 1337)]
    expect(cache_server.to_s).to eq('42 1 1337')
  end
end

# frozen_string_literal: true
require_relative '../app/connection.rb'

RSpec.describe Connection do
  it 'works' do
    cache_server = double(:cache_server)
    endpoint = double

    connection = Connection.new(120, cache_server, endpoint)

    expect(connection.latency).to eq(120)
    expect(connection.cache_server).to be(cache_server)
    expect(connection.endpoint).to be(endpoint)
  end
end

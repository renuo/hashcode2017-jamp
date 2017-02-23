# frozen_string_literal: true
require_relative '../app/file_reader.rb'

RSpec.describe FileReader do
  it 'works' do
    world = FileReader.new('input_sets/simple.in').world
    expect(world.endpoints.count).to eq(2)
    expect(world.cache_servers.count).to eq(3)
    expect(world.endpoints[0].requests.count).to eq(3)
    expect(world.endpoints[1].requests.count).to eq(1)
    expect(world.requests.count).to eq(4)
  end

  it 'works reading the file' do
    world = FileReader.new('input_sets/simple.in').world
    expect(world.endpoints.count).to eq(2)
    expect(world.cache_servers.count).to eq(3)
    expect(world.endpoints[0].requests.count).to eq(3)
    expect(world.endpoints[1].requests.count).to eq(1)
    expect(world.requests.count).to eq(4)
  end
end

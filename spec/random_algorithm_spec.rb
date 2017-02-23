# frozen_string_literal: true
require_relative '../app/random_algorithm.rb'
require_relative '../app/cache_server.rb'
require_relative '../app/endpoint.rb'
require_relative '../app/world.rb'
require_relative '../app/video.rb'
require_relative '../app/request.rb'
require_relative '../app/connection.rb'

RSpec.describe RandomAlgorithm do
  before do
    @world = World.example
  end

  it 'returns a list with 4 cache_server' do
    RandomAlgorithm.new(@world).solve
  end
end

# frozen_string_literal: true
require_relative 'solution.rb'
require_relative 'basic_algorithm.rb'
require_relative 'random_algorithm.rb'

class CombinedAlgorithm
  def initialize(world)
    @world = world
  end

  def solve
    basic_algo = BasicAlgorithm.new(@world)
    basic_algo.solve

    random_algo = RandomAlgorithm.new(basic_algo.world)
    random_algo.solve

    Solution.new(random_algo.world.cache_servers)
  end
end

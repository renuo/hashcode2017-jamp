#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'file_reader.rb'
require_relative 'file_writer.rb'
require_relative 'random_algorithm.rb'
require_relative 'basic_algorithm.rb'
require_relative 'combined_algorithm.rb'
require_relative 'rodi_algorithm.rb'

# e.g. call it like that:
# ruby solver.rb medium SplitterAlgorithm
puts 'hello! '
input_file_name = ARGV[0] || 'simple'

algorithm_name = ARGV[1] || 'BasicAlgorithm'

algorithm = Object.const_get(algorithm_name)
file_path = "input_sets/#{input_file_name}.in"
Dir.mkdir "output_sets/#{algorithm_name}" unless File.exists?("output_sets/#{algorithm_name}")
output_path = "output_sets/#{algorithm_name}/#{input_file_name}.out"
world = FileReader.new(file_path).world
solution = algorithm.new(world).solve
puts 'invalid solution' unless solution.valid?
FileWriter.new(solution, output_path).write_out
puts "I served your solution in #{output_path}."

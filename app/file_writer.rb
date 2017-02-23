# frozen_string_literal: true
class FileWriter
  def initialize(solution, output_path)
    @solution = solution
    @output_path = output_path
  end

  def write_out
    File.open(@output_path, 'w') do |file|
      file.puts @solution.cache_servers.count
      @solution.cache_servers.each do |cache_server|
        file.puts cache_server
      end
    end
  end
end

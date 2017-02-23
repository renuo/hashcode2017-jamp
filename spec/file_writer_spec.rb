# frozen_string_literal: true
require_relative '../app/file_writer.rb'
require_relative '../app/solution.rb'
require_relative '../app/cache_server.rb'
require_relative '../app/video.rb'

RSpec.describe FileWriter do
  it 'works' do
    videos = [Video.new(0, 50), Video.new(1, 50), Video.new(2, 80), Video.new(3, 30), Video.new(4, 110)]

    cache_server_0 = CacheServer.new(0, 100)
    cache_server_0.videos = [videos[2]]

    cache_server_1 = CacheServer.new(1, 100)
    cache_server_1.videos = [videos[3], videos[1]]

    cache_server_2 = CacheServer.new(2, 100)
    cache_server_2.videos = [videos[0], videos[1]]

    solution = Solution.new([cache_server_0, cache_server_1, cache_server_2])

    @buffer = StringIO.new
    @filename = 'ouput.txt'
    @expected_output = <<~OUTPUT
      3
      0 2
      1 3 1
      2 0 1
    OUTPUT

    allow(File).to receive(:open).with(@filename, 'w').and_yield(@buffer)

    file_writer = FileWriter.new(solution, @filename)
    file_writer.write_out

    expect(@buffer.string).to eq(@expected_output)
  end
end

# frozen_string_literal: true
require_relative '../app/solution.rb'
require_relative '../app/video.rb'
require_relative '../app/cache_server.rb'

RSpec.describe Solution do
  let(:solution) do
    videos = [Video.new(0, 50), Video.new(1, 50), Video.new(2, 80), Video.new(3, 30), Video.new(4, 110)]

    cache_server_0 = CacheServer.new(0, 100)
    cache_server_0.videos = [videos[2]]

    cache_server_1 = CacheServer.new(1, 100)
    cache_server_1.videos = [videos[3], videos[1]]

    cache_server_2 = CacheServer.new(2, 100)
    cache_server_2.videos = [videos[0], videos[1]]

    Solution.new([cache_server_0, cache_server_1, cache_server_2])
  end

  describe '#valid?' do
    it 'is valid' do
      expect(solution.valid?).to be_truthy
    end

    it 'detects duplicate cache servers' do
      solution.cache_servers << solution.cache_servers.first
      expect(solution.valid?).to be_falsey
    end

    it 'detects duplicate videos' do
      solution.cache_servers.first.videos << solution.cache_servers.first.videos.first
      expect(solution.valid?).to be_falsey
    end
  end
end

# frozen_string_literal: true
class Solution
  attr_accessor :cache_servers

  def initialize(cache_servers)
    @cache_servers = cache_servers
  end

  def valid?
    no_duplicate_cache_servers? && no_duplicate_videos?
  end

  private

  def no_duplicate_cache_servers?
    @cache_servers.map(&:id).count == @cache_servers.map(&:id).uniq.count
  end

  def no_duplicate_videos?
    @cache_servers.all? do |cache_server|
      cache_server.videos.map(&:id).count == cache_server.videos.map(&:id).uniq.count
    end
  end
end

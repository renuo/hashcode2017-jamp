# frozen_string_literal: true
class Connection
  attr_accessor :latency, :cache_server, :endpoint

  def initialize(latency, cache_server, endpoint)
    @latency = latency
    @cache_server = cache_server
    @endpoint = endpoint
  end

  def to_s
    "#{@endpoint.id} --> #{@cache_server.id}: #{@latency}"
  end
end

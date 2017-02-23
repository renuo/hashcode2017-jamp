# frozen_string_literal: true
class Request
  attr_accessor :video, :amount, :endpoint

  def initialize(video, endpoint, amount)
    @video = video
    @endpoint = endpoint
    @amount = amount
  end
end

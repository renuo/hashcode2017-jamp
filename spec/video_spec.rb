# frozen_string_literal: true
require_relative '../app/video.rb'

RSpec.describe Video do
  it 'works' do
    video = Video.new(1, 20)
    expect(video.id).to eq(1)
    expect(video.size).to eq(20)
  end
end

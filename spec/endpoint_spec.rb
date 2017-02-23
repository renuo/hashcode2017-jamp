# frozen_string_literal: true
require_relative '../app/endpoint.rb'

RSpec.describe Endpoint do
  it 'works' do
    connections = []
    requests = []
    endpoint = Endpoint.new(10)
    expect(endpoint.id).to eq(10)
  end
end

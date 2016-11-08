require 'rails_helper'

RSpec.describe LinkParser do
  it 'should initialize with a parsed input' do
    link = LinkParser.new('http://www.example.com \:cc friend@example.com')

    expect(link.parsed_input).to eq ['http://www.example.com', '\:cc', 'friend@example.com']
  end

  it 'should return a url' do
    link = LinkParser.new('http://www.example.com \:cc friend@example.com')

    expect(link.url).to eq 'http://www.example.com'
  end

  it 'should return a command' do
    link = LinkParser.new('http://www.example.com \:cc friend@example.com')

    expect(link.command).to eq '\:cc'
  end

  it 'should return a recipient' do
    link = LinkParser.new('http://www.example.com \:cc friend@example.com')

    expect(link.recipient).to eq 'friend@example.com'
  end

  it 'should approve emails with a proper command' do
    link = LinkParser.new('http://www.example.com \:cc friend@example.com')

    expect(link.should_be_emailed?).to eq true
  end

  it 'should not approve emails without a proper command ' do
    link = LinkParser.new('http://www.example.com hi friend@example.com')

    expect(link.should_be_emailed?).to eq false
  end
end

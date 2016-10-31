require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:read) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  it 'should have a default read value of false' do
    link = Link.create(
      url: 'http://www.example.com',
      title: 'Example',
      user_id: 1
    )

    expect(link.read).to eq false
  end
end

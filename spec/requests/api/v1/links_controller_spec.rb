require 'rails_helper'

describe 'Links' do
  context "#Index" do
    it 'can return all links' do
      user = User.create(email_address: 'david@example.com', password: 'password')
      saved_link = user.links.create(title: 'Turing', url: 'http://turing.io')

      login(user)

      get "/api/v1/users/#{user.id}/links"
      
      links = JSON.parse(response.body)
      link = links.first

      expect(response).to be_success
      expect(links.length).to eq(1)
      expect(links.class).to eq(Array)
      expect(link.class).to eq(Hash)
      expect(link['title']).to eq(saved_link.title)
      expect(link['url']).to eq(saved_link.url)
      expect(link['read']).to eq(saved_link.read)
      expect(link['user_id']).to eq(saved_link.user_id)
    end
  end
end

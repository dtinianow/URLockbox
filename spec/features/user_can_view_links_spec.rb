require 'rails_helper'

RSpec.feature "User can view links" do
  context 'they are logged in' do
    scenario "they visit their links path and see links" do
      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      expect(page).to have_content 'My Links'

      within('#links-table') do
        expect(page).to have_content(link.url)
        expect(page).to have_content(link.title)
        expect(page).to have_content(link.read)
      end
    end
  end

  context 'another user exists' do
    scenario "they only see their own links" do
      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')
      other_user = User.create(email_address: 'joe@example.com', password: 'password')
      other_link = other_user.links.create(url: 'https://www.google.com', title: 'Google')

      login(user)

      click_on 'My Links'

      expect(page).to_not have_content(other_link.url)
      expect(page).to_not have_content(other_link.title)
    end
  end
end

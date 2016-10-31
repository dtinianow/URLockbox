require 'rails_helper'

RSpec.feature "User can edit a link", js: true do
  context 'they click edit on their homepage' do
    scenario "they fill out a form and the changes appear on their homepage" do

      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      expect(link.read).to eq false

      within('.link-read-status') do
        expect(page).to have_content false
      end

      within('#links-table') do
        click_on 'Mark as Read'
      end

      within('.link-read-status') do
        expect(page).to have_content true
      end

      expect(user.links.first.read).to eq true
      expect(page).to have_content 'Mark as Unread'
    end
  end
end

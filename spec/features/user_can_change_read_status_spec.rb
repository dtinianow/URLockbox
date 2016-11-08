require 'rails_helper'

RSpec.feature "User can change read status of a link", js: true do
  context 'they click the "Mark as Read" button' do
    scenario "the button text and the status change" do

      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      expect(link.read).to eq false
      expect(page).to_not have_css '.read-link'

      within('.link-read-status') do
        expect(page).to have_content false
      end

      within('#links-table') do
        click_on 'Mark as Read'
      end

      within('.link-read-status') do
        expect(page).to have_content true
      end

      expect(page).to have_css '.read-link'
      expect(user.links.first.read).to eq true
      expect(page).to have_content 'Mark as Unread'
    end
  end

  context 'they click the "Mark as Unread" button' do
    scenario "the button text and the status change" do

      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing', read: true)

      login(user)

      click_on 'My Links'

      expect(link.read).to eq true
      expect(page).to have_css '.read-link'

      within('.link-read-status') do
        expect(page).to have_content true
      end

      within('#links-table') do
        click_on 'Mark as Unread'
      end

      within('.link-read-status') do
        expect(page).to have_content false
      end

      expect(page).to_not have_css '.read-link'
      expect(user.links.first.read).to eq false
      expect(page).to have_content 'Mark as Read'
    end
  end
end

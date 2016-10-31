require 'rails_helper'

RSpec.feature "User can edit a link" do
  context 'they click edit on their homepage' do
    scenario "they fill out a form and the changes appear on their homepage" do

      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      within('#links-table') do
        expect(page).to have_content(link.url)
        expect(page).to have_content(link.title)
        expect(page).to have_content(link.read)
      end

      click_on 'Edit'

      expect(current_path).to eq edit_link_path(link)

      within('#edit-link-form') do
        fill_in 'link[title]', with: 'Google'
        fill_in 'link[url]', with: 'http://www.google.com'
        click_on 'Save'
      end

      expect(current_path).to eq links_path

      within('#links-table') do
        expect(page).to_not have_content(link.url)
        expect(page).to_not have_content(link.title)
        expect(page).to have_content(link.read)
        expect(page).to have_content('Google')
        expect(page).to have_content('http://www.google.com')
      end
    end
  end
end

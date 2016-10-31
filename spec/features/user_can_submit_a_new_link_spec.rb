require 'rails_helper'

RSpec.feature "User can view links" do
  context 'they submit a new link' do
    scenario "it appears on their homepage" do
      user = User.create(email_address: 'david@example.com', password: 'password')

      login(user)

      click_on 'My Links'

      expect(page).to have_content 'My Links'

      within('#new-link-form') do
        fill_in 'link[title]', with: 'Turing'
        fill_in 'link[url]', with: 'http://www.turing.io'
        click_on 'Save'
      end

      expect(page).to have_content 'Turing'
      expect(page).to have_content 'http://www.turing.io'
    end
  end

  context 'they submit an invalid new link' do
    scenario "they get an error message" do
      user = User.create(email_address: 'david@example.com', password: 'password')

      login(user)

      click_on 'My Links'

      expect(page).to have_content 'My Links'

      within('#new-link-form') do
        fill_in 'link[title]', with: 'Turing'
        fill_in 'link[url]', with: 'www.turing.io'
        click_on 'Save'
      end

      expect(page).to have_content 'Invalid link. Please make sure you have a valid URL and enter all parameters.'
    end
  end
end

require 'rails_helper'

RSpec.feature "User can view links" do
  context 'they are logged in' do
    scenario "they visit their links path and see links" do
      user = User.create(email_address: 'david@example.com', password: 'password')
      link = Link.create(user: user, url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      expect(page).to have_content 'My Links'

      within('#links-table') do
        expect(page).to have_content('https://turing.io')
        expect(page).to have_content('Turing')
      end
    end
  end
end

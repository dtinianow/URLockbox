require 'rails_helper'

RSpec.feature "User can sort links alphabetically", js: true do
  context 'they click the sort button' do
    scenario "the links appear in alphabetical order" do

      user = User.create(email_address: 'david@example.com', password: 'password')
      link = user.links.create(url: 'https://www.turing.io', title: 'Turing')
      link = user.links.create(url: 'https://www.google.com', title: 'Google')

      login(user)

      click_on 'My Links'

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Turing'
      end

      within('#links-table tbody tr:nth-child(2)') do
        expect(page).to have_content 'Google'
      end

      click_on 'Alphabetic Sort'

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Google'
      end

      within('#links-table tbody tr:nth-child(2)') do
        expect(page).to have_content 'Turing'
      end
    end

    context 'they click the sort button twice' do
      scenario "the links appear in reverse alphabetical order" do
        user = User.create(email_address: 'david@example.com', password: 'password')
        link = user.links.create(url: 'https://www.turing.io', title: 'Turing')
        link = user.links.create(url: 'https://www.google.com', title: 'Google')

        login(user)

        click_on 'My Links'

        within('#links-table tbody tr:nth-child(1)') do
          expect(page).to have_content 'Turing'
        end

        within('#links-table tbody tr:nth-child(2)') do
          expect(page).to have_content 'Google'
        end

        click_on 'Alphabetic Sort'
        click_on 'Alphabetic Sort'

        within('#links-table tbody tr:nth-child(1)') do
          expect(page).to have_content 'Turing'
        end

        within('#links-table tbody tr:nth-child(2)') do
          expect(page).to have_content 'Google'
        end
      end
    end
  end
end

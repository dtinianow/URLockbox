require 'rails_helper'

RSpec.feature "User can filter links by status", js: true do
  context 'they click the read button' do
    scenario 'they only see read links in the table' do
      user = User.create(email_address: 'david@example.com', password: 'password')
      user.links.create(url: 'https://www.turing.io', title: 'Turing')
      user.links.create(url: 'https://www.google.com', title: 'Google')

      login(user)

      click_on 'My Links'

      within('#links-table tbody tr:nth-child(2)') do
        expect(page).to have_content 'Google'
      end

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Turing'

        click_on 'Mark as Read'
      end

      within('#filter-by-status') do
        click_on 'Read'
      end

      expect(page).to_not have_css '#links-table tbody tr:nth-child(2)'
      expect(page).to_not have_content 'Google'

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Turing'
      end
    end
  end

  context 'they click the unread button' do
    scenario "they only see unread links in the table" do
      user = User.create(email_address: 'david@example.com', password: 'password')
      user.links.create(url: 'https://www.google.com', title: 'Google')
      user.links.create(url: 'https://www.turing.io', title: 'Turing')

      login(user)

      click_on 'My Links'

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Google'
      end

      within('#links-table tbody tr:nth-child(2)') do
        expect(page).to have_content 'Turing'

        click_on 'Mark as Read'
      end

      within('#filter-by-status') do
        click_on 'Unread'
      end

      expect(page).to_not have_css '#links-table tbody tr:nth-child(2)'
      expect(page).to_not have_content 'Turing'

      within('#links-table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Google'
      end
    end

    context 'they click the all button' do
      scenario "they only see all links in the table" do
        user = User.create(email_address: 'david@example.com', password: 'password')
        user.links.create(url: 'https://www.turing.io', title: 'Turing', read: true)
        user.links.create(url: 'https://www.google.com', title: 'Google')

        login(user)

        click_on 'My Links'

        within('#filter-by-status') do
          click_on 'Read'
        end

        within('#links-table tbody tr:nth-child(1)') do
          expect(page).to have_content 'Turing'
        end

        expect(page).to_not have_content 'Google'

        within('#filter-by-status') do
          click_on 'All'
        end

        within('#links-table tbody') do
          expect(page).to have_content 'Google'
          expect(page).to have_content 'Turing'
        end
      end
    end
  end
end

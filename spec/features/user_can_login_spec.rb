require 'rails_helper'

RSpec.feature "User can login" do
  context 'with an existing account' do
    scenario "they visit the root path, enter credentials, and see homepage" do
      User.create(email_address: 'david@example.com', password: 'password')

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in "Email address", with: "david@example.com"
      fill_in "Password", with: "password"
      click_on "Login"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logged in as david@example.com")
      expect(page).to have_no_content("Login")
      expect(page).to have_content("Logout")
    end
  end

  context 'by creating a new account' do
    scenario "they submit credentials and end up on dashboard" do
      User.create(email_address: "david@example.com", password: "password")

      visit root_path

      click_on "Create New Account"

      fill_in "Email address", with: "david@example.com"
      fill_in "Password", with: "password"
      click_button "Create Account"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logged in as david@example.com")
    end
  end

  context 'they can logout once logged in' do
    scenario "they click logout and return to root path" do
      User.create(email_address: "david@example.com", password: "password")

      visit login_path

      fill_in "Email address", with: "david@example.com"
      fill_in "Password", with: "password"
      click_button "Login"
      click_on "Logout"

      expect(page).to have_no_content("Logged in as david@example.com")
      expect(page).to have_content("Login")
      expect(page).to have_no_content("Logout")
    end
  end
end

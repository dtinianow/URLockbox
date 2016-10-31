require 'rails_helper'

RSpec.feature "User can view links" do
  context 'they are logged in' do
    scenario "they visit their links path and see links" do
      user = User.create(email_address: 'david@example.com', password: 'password')

      login(user)

      click_on 'My Links'

      expect(page).to have_content 'My Links'
    end
  end
end

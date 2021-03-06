require 'rails_helper'

describe 'signing up and logging in' do

  describe 'login' do
    it 'should redirect the user back to the page they got to login from' do
      # any arbitrary CMS page is a good starting point
      starting_path = Comfy::Cms::Page.published.last.full_path
      visit starting_path

      click_on('Log In', match: :first)

      expect(current_path).to eq(new_user_session_path)

      fake_password = Faker::Internet.password
      user = User.create(email: Faker::Internet.email, password: fake_password, password_confirmation: fake_password)
      page.fill_in('Email', with: user.email)
      page.fill_in('Password', with: fake_password)

      click_button('Log In')

      expect(current_path).to eq(starting_path)
    end
  end
end

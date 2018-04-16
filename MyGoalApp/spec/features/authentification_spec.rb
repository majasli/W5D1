require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in "Username", with: "Maja"
      fill_in "Password", with: "starwars"
      click_button "Sign Up"
      expect(page).to have_content "Maja"
    end
  end
end


feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    sign_up
    sign_in
    expect(page).to have_content "Maja"
  end
end

feature 'logging out' do
  before :each do
    sign_up
    sign_in
  end

  scenario 'begins with a logged out state' do
    click_button "Sign Out"
    expect(page).to have_content "Sign In"
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_button "Sign Out"
    expect(page).to_not have_content "Maja"
  end
end

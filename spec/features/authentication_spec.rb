require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in('username', with: 'username')
      fill_in('password', with: 'password')
      click_on('submit')

      expect(page).to have_content("Index")
    end
  end
end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    u = User.create(username: 'username', password: 'password')

    visit new_session_url
    fill_in('username', with: 'username')
    fill_in('password', with: 'password')
    click_on('submit')

    # expect(page).to have_current_path(root_url)
    expect(page).to have_content(u.username)
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    u = User.create(username: 'username', password: 'password')

    expect(page).not_to have_content(u.username)
  end

  scenario "doesn't show username on the homepage after logout" do
    u = User.create(username: 'username', password: 'password')

    visit new_session_url
    fill_in('username', with: 'username')
    fill_in('password', with: 'password')
    click_on('submit')

    click_on('logout')

    expect(page).not_to have_content(u.username)
  end

end

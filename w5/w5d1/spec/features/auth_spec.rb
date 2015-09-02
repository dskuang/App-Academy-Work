require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do

    visit '/users/new'
    expect(page).to have_content "New User"
  end
  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
      fill_in 'Username', :with => "test"
      fill_in 'Password', :with => "password"
      click_on "Sign Up"
    end

    let(:username){User.new(:password => "bob")}
    it "validates presence of username" do
      expect(username).not_to be_valid
    end

    let(:password){User.new(:username => "bob",:password => "123")}
    it "validates length of password" do
      expect(password).not_to be_valid
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "test"
    end

  end

end

  feature "logging in" do

    it "has a login page" do
      visit '/session/new'
      expect(page).to have_content "Log In"
    end

  # feature "logging in a user" do
    # before(:each) do
    #   visit new_session_url
    #   expect(page).to have_content "Username"
    #   expect(page).to have_content "Password"
    #   fill_in 'Username', :with => "test"
    #   fill_in 'Password', :with => "password"
    #   click_on "Log In"
    # end

    it "shows username on the homepage after login" do
      sign_up_as_apple_bottoms
      expect(page).to have_content "apple_bottoms"
    end

    feature "logging out" do

    before(:each) do
      visit new_session_url
      fill_in 'Username', :with => "apple_bottoms"
      fill_in 'Password', :with => "password"
      click_on "Log In"
    end

    it "begins with logged out state" do
      sign_up_as_apple_bottoms
      click_on "Log Out"
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
    end

    it "doesn't show username on the homepage after logout" do
      expect(page).not_to have_content "apple_bottoms"
    end

  end

end

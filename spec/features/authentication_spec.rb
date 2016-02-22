require 'rails_helper'

feature 'Authentication' do
  scenario 'User logins correctly' do
    user = FactoryGirl.create :user, email: "fred@fred.com", password: "secret"
    visit root_path
    click_link "Login"
    
    fill_in :email, with: "fred@fred.com"
    fill_in :password, with: "secret"
    click_button "Login"
    
    current_path.should eq(root_path)
    page.should have_content("logged in")
    page.should have_content(user.name)
  end
end
require 'rails_helper'

feature 'Site' do
  scenario "user visits home page and sees home" do
    visit root_path
    
    page.should have_content("Home")
  end
  
  scenario "user vistis about page and sees about" do
    visit root_path
    
    page.should have_content("About")
  end
end
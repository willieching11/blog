require 'capybara/rspec'

module AuthenticationMacros
  def login_a_user(user_attributes = {})
    user_attributes[:password] ||= "secret"
    user = FactoryGirl.create :user, user_attributes
    
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user_attributes[:password]
    click_button "Login"
    user
  end
end
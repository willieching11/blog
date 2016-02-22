require 'rails_helper'

feature 'Articles:' do
  scenario 'User creates an article' do
   login_a_user
   
   visit articles_path
   click_link "New Article"
   
   fill_in "Title", with: "My new test article"
   fill_in "Post", with: "My test post"
   click_button "Create Article"
   
   page.should have_content("Successfully created Article")
  end
  
  scenario 'User fails to create article' do
    login_a_user
   
    visit new_article_path
   
    fill_in "Title", with: ""
    fill_in "Post", with: "test"
    click_button "Create Article"
   
    page.should have_content("fix the errors")
  end

  scenario 'User views an article' do
   user = login_a_user
   article = FactoryGirl.create :article, user: user
   visit articles_path
   click_link "Show"
   page.should have_content(article.title)
   
  end

  scenario 'User deletes an article' do
   user = login_a_user
   article = FactoryGirl.create :article, user: user
   
   visit articles_path
   click_link("Delete", match: :first)

   #page.should have_content("Are you sure?")
   #click_button "Ok"

   page.should have_content("Deleted Article")
   page.should_not have_content(article.title)
  end

  scenario 'User edits an article' do
   user = login_a_user
   article = FactoryGirl.create :article, user: user

   visit article_path(article)
   click_link "Edit"

   fill_in "Title", with: "My updated test article"
   fill_in "Post", with: "My updated post"
   click_button "Update Article"

   page.should have_content("Successfully saved Article")
   page.should have_content("My updated test article")
  end
end
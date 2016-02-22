require 'rails_helper'

describe Article do
  it "should have a valid factory" do
  	FactoryGirl.build(:article).should be_valid
  end
  
  it "is invalid without a title" do
    article = FactoryGirl.build :article, title: ""
    
    article.should_not be_valid
    article.errors[:title].first.should == "can't be blank"
  end
 end
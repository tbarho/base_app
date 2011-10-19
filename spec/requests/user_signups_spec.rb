require 'spec_helper'

describe "When a user signs up" do
  before(:each) do
    @count = User.count
    @user = User.new(:username => "tester", :email => "test@example.com", :password => "secret")
    visit signup_path
    fill_in "user_username", :with => @user.username
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => @user.password
  end

  context "with valid attributes" do
    before do
      fill_in "user_password_confirmation", :with => @user.password
      click_button "Sign Up"
    end
    it "a new user is created in the system" do
      User.count.should eq(@count + 1)
    end
    it "the user is sent to the home page" do
      current_path.should eq root_path
    end
    it "the user is notified that an account was created" do
      page.should have_xpath("//div", :id => 'flash_success', :content => "created")
    end
    it "the user is signed in" do
      page.should have_xpath("//a", :content => "Sign Out")
    end
  end

  context "with invalid attributes" do
    before do
      fill_in "user_password_confirmation", :with => "wrong"
      click_button "Sign Up"
    end
    it "a new user should not be created" do
      User.count.should eq @count
    end
    it "the user should be sent back" do
      current_path.should eq "/users"
    end
    it "the user should be notified of errors" do
      page.should have_xpath("//div", :class => "error_messages")
    end
    it "the user should not be signed in" do
      page.should have_xpath("//a", :content => "Sign In")
    end
  end
end

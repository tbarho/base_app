require 'spec_helper'

describe "UserSignups" do
  before(:each) do
    visit signup_path
    fill_in "user_name", :with => "tester"
    fill_in "user_email", :with => "test@example.com"
    fill_in "user_password", :with => "secret"
    fill_in "user_password_confirmation", :with => "secret"
  end

  it "allows a user to signup" do
    click_button "Sign Up"
    current_path.should eq(root_path)
    page.should have_content("successfully signed up")
  end

  it "should validate name, email and password appropriately" do
    fill_in "user_name", :with => ""
    fill_in "user_email", :with => ""
    fill_in "user_password", :with => ""
    fill_in "user_password_confirmation", :with => ""
    click_button "Sign Up"
    current_path.should eq(signup_path)
    page.should have_content("Password digest can't be blank")
    page.should have_content("Name can't be blank")
    page.should have_content("Name is too short (minimum is 5 characters)")
    page.should have_content("Email can't be blank")
    page.should have_content("Email is invalid")
    page.should have_content("Password can't be blank")
    page.should have_content("Password is too short (minimum is 6 characters)")
  end

  it "should not allow duplicate names or emails" do
    user = Factory(:user)
    fill_in "user_name", :with => user.name
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => "secret"
    fill_in "user_password_confirmation", :with => "secret"
    click_button "Sign Up"
    current_path.should eq(signup_path)
    page.should have_content("Name already exists")
    page.should have_content("Email already exists")
    
  end


end

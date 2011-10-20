require 'spec_helper'

describe "When a user signs out" do
  before do
    @user = Factory(:user)
    visit signin_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign In"
    click_link "Sign Out"
  end

  it "they should be signed out of the system" do
    page.should_not have_content("#{@user.username}")
    page.should_not have_content("#{@user.email}")
    page.should have_xpath("//a", :content => "Sign In")
  end
  it "they should be sent to the home page" do
    current_path.should eq root_path
  end
  it "they should be notified that they are signed out" do
    page.should have_xpath("//div", :id => "flash_success", :content => "signed out")
  end
end

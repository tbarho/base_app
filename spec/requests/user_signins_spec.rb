require 'spec_helper'

describe "When a user signs in" do
  before do
    @user = Factory(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", :with => @user.email
  end

  context "with valid credentials" do
    before do
      fill_in "Password", :with => @user.password
      click_button "Sign In"
    end
    it "the user is sent to the users home page" do
      current_path.should eq user_path(@user)
    end
    it "the user can see their username on the page" do
      page.should have_content("#{@user.username}")
    end
    it "the user can see an option to sign out" do
      page.should have_xpath("//a", :content => "Sign Out")
    end
  end

  context "with invalid credentials" do
    before do
      fill_in "Password", :with => "wrong"
      click_button "Sign In"
    end
    it "the user is sent back to the sign in page" do
      current_path.should eq("/sessions")
    end
    it "the user should not see a username on the page" do
      page.should_not have_content("#{@user.username}")
    end
    it "the user is notified of the sigin in errors" do
      page.should have_xpath("//div", :content => "Invalid")
    end
  end

end

require 'spec_helper'

describe "When an admin signs in" do
  let(:admin) { Factory(:user) }
  let(:user) { Factory(:user) }

  before do
    admin.roles = ["admin"]
    admin.save
    visit signin_path
  end

  context "with valid admin priveledges" do
    before do
      fill_in "Email", :with => admin.email
      fill_in "Password", :with => admin.password
      click_button "Sign In"
    end
    it "they should see an admin toolbar" do
      page.should have_selector("#admin_toolbar")
    end

    context "visiting the users page" do
      before do
        visit users_path
      end
      it "they should see the users page with admin links" do
        current_path.should eq(users_path)
        page.should have_xpath("//h1", :content => "Users")
        page.should have_xpath("//a", :content => "Add User")
        page.should have_xpath("//a", :content => "Edit User")
        page.should have_xpath("//a", :content => "Destroy User")
      end
    end
  end

  context "without valid admin priveledges" do
    before do
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign In"
    end
    it "they should not see an admin toolbar" do
      page.should_not have_selector("#admin_toolbar")
    end

    context "visiting the users page" do
      before do
        visit users_path
      end
      it "they should not see any admin links" do
        current_path.should eq(users_path)
        page.should have_xpath("//h1", :content => "Users")
        page.should_not have_xpath("//a", :content => "Add User")
        page.should_not have_xpath("//a", :content => "Edit User")
        page.should_not have_xpath("//a", :content => "Destroy User")
      end
    end
  end    

end

require 'spec_helper'


describe "UserSignups" do
  context "as a guest on the sign up page" do
    let(:user) { User.new(:username => 'tester', 
                          :email => 'test@example.com', 
                          :password => 'secret') 
               }
    before do
      @count = User.count
    end

    context "with valid attributes" do
      before do
        visit signup_path
        fill_in "user_username", :with => user.username
        fill_in "user_email", :with => user.email
        fill_in "user_password", :with => user.password
        fill_in "user_password_confirmation", :with => user.password
        click_button "Sign Up"
      end
      it "adds a new user to the system" do
        User.count.should eq(@count + 1)
      end
      it "sends the user to the home page" do
        current_path.should eq root_path
      end
      it "tells the user they successfully signed up" do
        page.should have_xpath('//div', :id => 'flash_notice', :content => "#{user.username}")
      end
    end

    context "with invalid attributes" do
      before do
        visit signup_path
        click_button "Sign Up"
      end
      it "does not add a user to the system" do
        User.count.should == @count
      end
      it "sends the user back to the signup form" do
        current_path.should eq "/users"
      end
      it "tells the user why sign up failed" do
        page.should have_xpath('//div', :id => 'error_messages')
      end
    end

  end
end

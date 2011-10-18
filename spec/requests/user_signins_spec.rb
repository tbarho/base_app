require 'spec_helper'

describe "UserSignins" do

  context "as a guest on the signin page" do
    let(:user) { Factory(:user) }

    context 'with valid credentials' do
      before do
        visit signin_path
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => 'secret'
        click_button 'Sign In'
      end

      it "knows who I am" do
        within('div#flash_notice') do
          page.should have_content("#{user.username}")
        end 
      end

      it "sends me to to the root page" do
        current_path.should eq root_path  
      end

      it "has a signout link" do
        page.should have_xpath('//a', :text => 'Sign Out')
      end
    end

    context 'with invalid credentials' do
      before do
        visit signin_path
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => ''
        click_button 'Sign In'
      end

      it 'takes me back to the sign in page' do
        current_path.should eq "/sessions"
      end

      it 'tells me there was an invalid email or password' do
        page.should have_xpath('//div', :id => 'flash_alert', :text => 'Invalid email or password')
      end 
    end
  end

end

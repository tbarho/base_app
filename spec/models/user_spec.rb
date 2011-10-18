require 'spec_helper'

describe User do
  
  describe "validations" do
    before(:each) do
     @attr = { :username => "Test Tester", :email => "test@example.com", :password => "secret", :password_confirmation => "secret" }
    end

    it "should create an instance give valid attributes" do
      User.create!(@attr)
    end
    it "should require a username" do
      User.new(@attr.merge(:username => "")).should_not be_valid
    end
    it "should require an email" do
      User.new(@attr.merge(:email => "")).should_not be_valid
    end
    it "should require a password" do
      User.new(@attr.merge(:password => "")).should_not be_valid
    end
    it "should require a password_confirmation" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    it "should not allow short usernames" do
      User.new(@attr.merge(:username => "a" * 4)).should_not be_valid
    end
    it "should not allow long usernames" do
      User.new(@attr.merge(:username => "a" * 51)).should_not be_valid
    end
    it "should not allow duplicate (case-insensitive) user names" do
      username = @attr[:username].upcase
      User.create!(@attr)
      User.new(@attr.merge(:username => username)).should_not be_valid
    end
    it "should not allow invalid email addresses" do
      bad = %w{ test test@example testexample.com test@example,com test@example. }
      bad.each do |address|
        User.new(@attr.merge(:email => address)).should_not be_valid
      end
    end
    it "should not allow duplicate (case-insensitive) email addresses" do
      upper_cased = @attr[:email].upcase
      User.create!(@attr)
      User.new(@attr.merge(:email => upper_cased)).should_not be_valid
    end
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    it "should not allow short passwords" do
      password = "a" * 5
      User.new(@attr.merge(:password => password, :password_confirmation => password)).should_not be_valid
    end
    it "should not allow long passwords" do
      password = "a" * 41
      User.new(@attr.merge(:password => password, :password_confirmation => password)).should_not be_valid
    end
  end

  describe "associations" do

  end

end

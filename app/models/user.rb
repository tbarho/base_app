class User < ActiveRecord::Base
  has_secure_password
  validates :username,      :presence => true,
                        :length => { :within => 5..50 },
                        :uniqueness => { :case_sensitive => false }
  validates :email,     :presence => :true,
                        :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                        :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true,
                        :length => { :within => 6..40 }
end

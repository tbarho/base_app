class User < ActiveRecord::Base
  ROLES = %w[admin]

  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  validates :username,  :presence => true,
                        :length => { :within => 5..50 },
                        :uniqueness => { :case_sensitive => false }
  validates :email,     :presence => :true,
                        :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                        :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true,
                        :length => { :within => 6..40 }
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def has_role?(role)
    roles.include?(role)
  end

  def admin?
    has_role?("admin")
  end

end

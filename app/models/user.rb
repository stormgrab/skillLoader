require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt
  
	attr_accessible :dob, :dp_url, :email, :password, :terms_of_service, 
									:new_password, :new_password_confirmation, :login_password
	attr_accessor :new_password, :new_password_confirmation, :login_password

	has_many :posts 
	has_many :comments
	
	validates :email, uniqueness: {case_sensitive: false}	, presence: true
	validates :terms_of_service, acceptance: true
	validates :new_password, confirmation: true, if: :password_changed?

	before_save :hash_new_password, if: :password_changed?

	#To avoid null from being saved as password
	def password_changed?
      !@new_password.blank?
  end

	private
	def hash_new_password
		self.password = BCrypt::Password.create(@new_password)
	end

	
  def self.authenticate(email, password)
    if user = find_by_email(email)
     if BCrypt::Password.new(user.password).is_password? password
        return user
      end
    end
    return nil
  end
  
end

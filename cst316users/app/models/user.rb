#This model captures an individual 'User' object from the users table.
class User < ActiveRecord::Base

  #Allows the model to view password_confirmation, password_confirmation is in the new.html.erb
  attr_accessor :password_confirmation

  #These are callbacks, they exist for ActiveRecord derivations to inject methods between database actions.
  #I wrote these ones to make function calls to encrypt the password before saving, and to clear the (plain text) password.
  before_save :encrypt_password
  after_save :clear_password

  #Defines a regular expression for emails, validates can be used on specific methods.
  #No validations for Firstname and Lastname, because I don't know what to write for constraints.
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :USERNAME, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :EMAIL, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :PASSWORD, :confirmation => true
  validates_length_of :PASSWORD, :in => 6..35, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  #authenticate method attempts to retrieve a specific user (their ID) from the database by the email or username.
  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      user = User.find_by_EMAIL(username_or_email)
    else
      user = User.find_by_USERNAME(username_or_email)
    end

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
     self.PASSWORD == BCrypt::Engine.hash_secret(login_password, self.SALT)
  end

  def encrypt_password
    unless self.PASSWORD.blank?
       self.SALT = BCrypt::Engine.generate_salt
       self.PASSWORD = BCrypt::Engine.hash_secret(self.PASSWORD, self.SALT)
    end
  end

  def clear_password
    self.PASSWORD = nil
  end
end


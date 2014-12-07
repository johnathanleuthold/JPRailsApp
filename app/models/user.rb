###########################################################################################################################
#Author: Johnathan Leuthold
#Date: 11-25-2014
#Modifications: 12-1-2014 Chad Greene
#Description: The User model inherits from ActiveRecord which facilitates the creation of the business object User, which
#is essentially a class whose attributes are the columns derived from the plural database table 'users'. ActiveRecord
#represents the persistence layer of the application.
###########################################################################################################################
#This model captures an individual 'User' object from the users table.
class User < ActiveRecord::Base
  
  has_many :recipes, dependent: :destroy
  has_many :comments
  has_many :ratings
  has_many :active_follows, class_name: "Follow",
                            foreign_key: "follower_id",
                            dependent: :destroy
  has_many :passive_follows, class_name: "Follow",
                             foreign_key: "followed_id",
                             dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  
  #These are callbacks, they exist for ActiveRecord derivations to inject methods between database actions.
  #I wrote these ones to make function calls to encrypt the password before saving, and to clear the (plain text) password.
  before_save :encrypt_password
  after_save :clear_password

  #Defines a regular expression for emails, validates can be used on specific methods.
  #No validations for Firstname and Lastname, because I don't know what to write for constraints.
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..25 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true, :length => { :in => 6..35 }, on: [:create]
  validates :password_confirmation, :presence => true, :on => :create
  
  ###########################################################################################################################
  #authenticate method attempts to retrieve a specific user (their ID) from the database by the email or username.
  ###########################################################################################################################
  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      #The find_by_"column name" are defined under ActiveRecord, User model has access because it inherits from ActiveRecord.
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end
  
  ###########################################################################################################################
  #The match_password function receives the user's login password, encrypts it with the salt and returns true if
  #what is in the database column password matches what the user submitted after hashing.
  ###########################################################################################################################
  def match_password(login_password="")
     self.password == BCrypt::Engine.hash_secret(login_password, self.salt)
  end
  
  ###########################################################################################################################
  #encrypt_password uses BCrypt to generate an encrypted salt, then hashes it together with the user's plain-text password
  #and that becomes the new value stored in the database, since encrypt_password is called before every new User.save call.
  ###########################################################################################################################
  def encrypt_password
    unless self.password.blank?
       self.salt = BCrypt::Engine.generate_salt
       self.password = BCrypt::Engine.hash_secret(self.password, self.salt)
    end
  end
  
  ###########################################################################################################################
  #This sets the current User's password to nil, and is called by the after_save callback, this does not affect the database.
  #Instead, this clears the current user instance's password so there is no plain text password floating around anymore.
  ###########################################################################################################################
  def clear_password
    self.password = nil
  end
end


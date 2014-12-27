require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "exampleUser", 
                     email: "example@user.com",
                     fname: "example",
                     lname: "user",
                     password: "peanut",
                     password_confirmation: "peanut")
  end
  
##USER TESTS####################################################################
  test "should be valid" do
    assert @user.valid?
  end
  
    #Testing Username
  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end
  
  test "username should be greater than 2 characters" do
    @user.username = "ab"
    assert_not @user.valid?
  end
  
  test "duplicate username should not be allowed" do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
  end
  
  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end
  
    #Testing email
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "email should be unique" do
    dup_user = @user.dup
    @user.save
    dup_user.username = "ExampleUser2"
    dup_user.email.upcase
    assert_not dup_user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a@" + "a" * 256 + ".com"
    assert_not @user.valid?
  end
  
    #Testing Password
  test "password should be at least 5 characters" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end
  
  

  
end

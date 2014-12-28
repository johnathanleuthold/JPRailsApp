require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  
  test "should be invalid register information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, user: { username: "",
                               email: "user@example.com",
                               password: "peanut",
                               password_confirmation: "peanut" }
    end
    assert_template 'shared/form'
  end
  
  test "valid register information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: "abcdef",
                                           email: "abc@def.com",
                                           password: 'password',
                                           password_confirmation: 'password' }
    end
    assert_template 'main_pages/home'
    assert_not flash.empty?
  end

end
#User controller class for user creation.
class UsersController < ApplicationController
#Creates a new user and places it in the @user class variable.
  def new
     @page_title = "UserAuth | Signup"
    @user = User.new
  end
#create saves a new user to the database (unless validation fails or information is missing) and returns
#"you signed up successfully", or, "Form is invalid" depending upon input.
  def create
    @user = User.new(user_params)
    if @user.save
      flash.alert = "Sign up successful"
      redirect_to login_path
    else
      flash.now.alert = "Form Error"
      render "new"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :password, :fname, :lname, :salt, :email, :password_confirmation)
    end
end

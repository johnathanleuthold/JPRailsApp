###########################################################################################################################
#Author: Johnathan Leuthold
#Date: 11-26-2014
#Modifications: 
#Description: The Users controller defines acceptable parameters to be taken from the user views and attempts to store
#them in a User business object before attempting to save it to the database, which will then be intercepted by the User
#model to perform necessary validation before changes are finalized.
###########################################################################################################################

#User controller class for user creation.
class UsersController < ApplicationController
  ###########################################################################################################################
  #Creates a new user and places it in the @user class variable.
  ###########################################################################################################################
  def new
    @page_title = "UserAuth | Signup"
    @user = User.new
  end
  ###########################################################################################################################
  #create saves a new user to the database (unless validation fails or information is missing) and returns
  #"you signed up successfully", or, "Form Error" depending upon input.
  ###########################################################################################################################
  def create
    @user = User.new(user_params)
    if @user.save
      #If save returns no errors the user is given affirmation of a successful sign up.
      flash.alert = "Sign up successful"
      #The user is then redirected to the login page (login_path is defined automatically in routes.rb by resource :users)
      #this takes the user to the login.html.erb page.
      redirect_to login_path
    else
      #If save returns errors the user is notified by a "Form Error" alert.
      flash.now.alert = "Form Error"
      #Render re-renderes the data on the new page, which is where the user is currently located, so a redirection is not
      #necessary, instead a render serves the purpose of displaying the page again with new form errors where appropriate.
      render "new"
    end
  end
  
  private
    ###########################################################################################################################
    #This private function defines the parameter list for the User.new so as to help obfuscate that information as well as
    #favor modular design should more methods require the appropriate user_params.
    ###########################################################################################################################
    def user_params
      params.require(:user).permit(:username, :password, :fname, :lname, :salt, :email, :password_confirmation)
    end
end

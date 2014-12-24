################################################################################
#Author: Johnathan Leuthold
#Date: 11-26-2014
#Modifications: 12-12-2014(Chad Greend) 
#Description: The Sessions controller class holds temporary user attributes 
#across multiple views with a session object.
################################################################################
class SessionsController < ApplicationController

  ##############################################################################
  # Builds new user session
  #
  # Entry: none
  #
  #  Exit: 
  ##############################################################################
  def new
  end
  
  ##############################################################################
  # Creates a semi permanent session that secure session used to pass data
  # between pages for authenticated users
  #
  # Entry: user not logged in
  #
  #  Exit: user authenticated and logged in
  ##############################################################################
  def create
      #find user
    user = User.find_by(username: params[:session][:username])  
      #authenticate user
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in(user)
          #if remember me box is checked create remember token/cookie
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash.alert = "Account not activated. Check email for activation link"
        redirect_to root_url
      end
    else
      flash.now.alert = "Invalid username/password combination"
      render 'new'
    end
  end
  
  ##############################################################################
  # Destroys the user session
  #
  # Entry: user may be logged in
  #
  #  Exit: session destroyed and user returned to root
  ##############################################################################
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end

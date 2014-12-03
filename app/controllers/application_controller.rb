###########################################################################################################################
#Author: Johnathan Leuthold
#Date: 11-26-2014
#Modifications: 
#Description: The Application controller contains override methods to prevent inappropriate views from being displayed
#to a user based on their current log in state. It does this from the sessions controller under its before_filter:
#callbacks, these filters call a method in the ApplicationController if certain methods in the sessions controller fire
#as a means of validating whether that method is appropriate.
###########################################################################################################################

class ApplicationController < ActionController::Base
protect_from_forgery
protected

  ###########################################################################################################################
  #This method is triggered if the user uses triggers any of these methods but these :index, :login, :login_attempt, 
  #and :logout. This method verifies that there is a session with a user_id in play, if not, it redirects the user to the
  #login page. If there is a session, this method assigns @current_user the user corresponding to that sessions user_id.
  ###########################################################################################################################
  def authenticate_user
    unless session[:user_id]
      #If there's no user_id in the current session the user is redirected to the login page.
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      #If there is a current user_id in the session @current_user will receive the User business object corresponding to
      #that ID.
      @current_user = User.find session[:user_id]
      return true
    end
  end

  ###########################################################################################################################
  #This method fires if the user tries to use the :index, :login, or :login_attempt methods in the sessions controller
  #if there is a user_id in the current session the user is redirected to the home page.
  ###########################################################################################################################
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def index
  end
end

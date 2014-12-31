################################################################################
#Author: Johnathan Leuthold
#Date: 11-26-2014
#Modifications: 
#Description: The Users controller defines acceptable parameters to be taken 
#from the user views and attempts to store them in a User business object before
#attempting to save it to the database, which will then be intercepted by the 
#User model to perform necessary validation before changes are finalized.
################################################################################

#User controller class for user creation.
class UsersController < ApplicationController
    #Ensures only the owner of the object can update and delete
  before_action :correct_user, only: [:update, :destroy]
  
    #Ensures that only admin users can delete users
  before_action :admin_user, only: :destroy
  
  ##############################################################################
  # Allows user registration
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def new
    @page_title = "Register"
    @btnText = "Register"
    @user = User.new
    @obj = @user
    render 'shared/form'
  end
  
  ##############################################################################
  # Saves a user record to the database.  Upon successful save an activation
  # email is generated and sent the the user that will be used to activate the
  # new account and verify the email.  On error the user is alerted about
  # invalid form values and allowed to correct and re-submit.
  #
  # Entry: @user is dirty form
  #
  #  Exit: user record saved to database
  ##############################################################################
  def create
    @user = User.new(user_params)
    @obj = @user
    if @user.save
      flash.notice = "Sign up successful. Check email for activation link"
      @user.send_activation_email
      redirect_to root_url
    else
      flash.now.alert = "Form Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Main profile page for a single user
  #
  # Entry: @user is found by user_id
  #
  #  Exit: user profile displayed
  ##############################################################################
  def show
    @user = User.find(params[:id])
    redirect_to(root_url) && return unless logged_in?
    @page_title = "User #{@user.username}"
  end
  
  ##############################################################################
  # Used to display ALL users
  #
  # Entry: @users is all users
  #
  #  Exit: none
  ##############################################################################
  def index
    @page_title = "All Users"
    @users = User.all
  end
  
  ##############################################################################
  # Allows user to change profile information
  #
  # Entry: @user is current user
  #
  #  Exit: none
  ##############################################################################
  def edit
    @user = current_user
    @page_title = "Edit Profile"
    @btnText = "Update Profiile"
    @obj = @user
    render 'shared/form'
  end
  
  ##############################################################################
  # Updates user profile information
  #
  # Entry: @user is dirty form
  #
  #  Exit: user record updated
  ##############################################################################
  def update
    @obj = @user
   if @user.update_attributes(user_params)
      flash.alert = "Profile updated"
      redirect_to current_user
    else
      render 'shared/form'
    end
  end
  
  ####
  
  ####
  def existinguser
    @data = request.filtered_parameters
    @username = @data['username']
    if (User.exists?(username: @username))
        @output = "exists"
      else
        @output = "free"
    end
    render json: @output
    #respond_to do |format|
     # format.json {render :json => { :success => "exists", :status_code => "200" }}
    #end
  end
  
  ####
  
  ####
  def existingemail
    @data = request.filtered_parameters
    @email = @data['email']
    if (User.exists?(email: @email))
        @output = "exists"
      else
        @output = "free"
    end
    render json: @output
  end
  
  ##############################################################################
  # Deletes a user record from the database
  #
  # Entry: user is found and destroyed by id
  #
  #  Exit: none
  ##############################################################################
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end
  
  ##############################################################################
  # Builds a list of users that are being followed
  #
  # Entry: @user is found by id
  #        @users are being followed
  #
  #  Exit: none
  ##############################################################################
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.all #paginate(page: params[:page])
    render 'show_follow'
  end
  
  ##############################################################################
  # Builds a list of users that are following the current user
  #
  # Entry: @user is found by id
  #        @users are following current user
  #
  #  Exit: none
  ##############################################################################
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.all #paginate(page: params[:page])
    render 'show_follow'
  end
  
#PRIVATE########################################################################  
private
  ##############################################################################
  # Allows only permitted parameters to be submitted and used on the pages
  ##############################################################################
  def user_params
    params.require(:user).permit(:username, :password, :fname, :lname, :email, 
                                 :password_confirmation)
  end
  
  ##############################################################################
  # Callback for controllers with @user object.  Used for checking whether or 
  # not the logged in user owns an object within the views.
  ##############################################################################
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?@user
  end
end

################################################################################
#Author: Chad Greene
#Date: 12-13-14
#Modifications: 
#Description: The Follows controller allows users to follow each other.
################################################################################
class FollowsController < ApplicationController
  ##############################################################################
  # Sets up a follow relationship between two users
  #
  # Entry: none
  #
  #  Exit: user followed
  ##############################################################################
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |f|
      f.html { redirect_to @user}
      f.js
    end
  end
  
  ##############################################################################
  # Removes follow relationship from two users
  #
  # Entry: none
  #
  #  Exit: user unfollowed
  ##############################################################################
  def destroy
    @user = Follow.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |f|
      f.html { redirect_to @user}
      f.js
    end
  end
end

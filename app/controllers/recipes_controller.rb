################################################################################
#Author: Chad Greene
#Date: 12-13-14
#Modifications: 
#Description: The Recipe controller allows users to have a collection of 
#             recipes.
################################################################################
class RecipesController < ApplicationController
    #Allow un-registered users access to all recipes
  skip_before_action :logged_in_user, only: :index
  
    #Ensures owner of object is allowed to edit and delete
  before_action -> { correct_user Recipe.find(params[:id]).user}, 
                   only: [:update, :destroy]
  
  ##############################################################################
  # Builds new user recipe
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def new
    @page_title = "New Recipe"
    @recipe = current_user.recipes.build
    @btnText = "Create Recipe"
    @obj = @recipe
    render 'shared/form'
  end
  
  ##############################################################################
  # Saves new recipe for user
  #
  # Entry: dirty form
  #
  #  Exit: form information saved to database
  ##############################################################################
  def create
    @recipe = current_user.recipes.build(recipe_params)
    @btnText = "Create Recipe"
    @obj = @recipe
    if(@recipe.save)
      redirect_to current_user
    else
      flash.now.alert = "Form Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Removes a user recipe from the database
  #
  # Entry: id is recipe id
  #
  #  Exit: recipe removed from database
  ##############################################################################
  def destroy
    current_user.recipes.find(params[:id]).destroy
    redirect_to current_user
  end
  
  ##############################################################################
  # Allows a user to edit a recipe
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def edit
    @page_title = "Edit Recipe"
    @recipe = current_user.recipes.find(params[:id])
    @btnText = "Create Recipe"
    @obj = @recipe
    render 'shared/form'
  end
  
  ##############################################################################
  # Updates a users recipe
  #
  # Entry: id is recipe id
  #        dirty form
  #
  #  Exit: recipe updated with form information
  ##############################################################################
  def update
    @recipe = current_user.recipes.find(params[:id])
    @obj = @recipe
    if(@recipe.update(recipe_params))
      flash.alert = "Recipe updated"
      redirect_to current_user
    else
      flash.now.alert = "Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Builds list of all recipes
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def index
    @page_title = "All Recipes"
    @recipes = Recipe.all
  end
  
  ##############################################################################
  # Displays a single recipe profile
  #
  # Entry: id is recipe_id
  #
  #  Exit: session[:recipe_id] set to recipe id
  ##############################################################################
  def show
    @recipe = Recipe.find(params[:id])
    @page_title = "#{@recipe.name}"
    session[:recipe_id] = @recipe.id
    @rating = @recipe.ratings.find_by(user_id: session[:user_id])
  end
  
#PRIVATE########################################################################  
  private
    ############################################################################
    # Allows only permitted parameters to be submitted and used on the pages
    ############################################################################
    def recipe_params
      params.require(:recipe).permit(:name)
    end
end
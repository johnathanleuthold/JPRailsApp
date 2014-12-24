################################################################################
#Author: Chad Greene
#Date: 12-13-14
#Modifications: 
#Description: The RecipeIngredients controller is a list of ingredients that
#go into a recipe including the type of ingredient, measurement and quantity.
################################################################################
class RecipeIngredientsController < ApplicationController
  include RecipeIngredientsHelper
  
  ##############################################################################
  # Builds new recipe ingredient for the current recipe
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def new
    @page_title = "New Recipe Ingredient"
    @recipe_ingredient = current_recipe.recipe_ingredients.build
    @btnText = "Add Ingredient"
    @obj = @recipe_ingredient
    render 'shared/form'
  end
  
  ##############################################################################
  # Saves new recipe ingredient for the current recipe
  #
  # Entry: dirty form
  #
  #  Exit: recipe ingredient created
  ##############################################################################
  def create
    @recipe_ingredient = current_recipe.recipe_ingredients.build(ri_params)
    @obj = @recipe_ingredient
    if @recipe_ingredient.save
      flash.alert = "Ingredient added"
      redirect_to current_recipe
    else
      flash.now.alert = "Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Edits recipe ingredient for the current recipe
  #
  # Entry: id is recipe_ingredient id
  #
  #  Exit: none
  ##############################################################################
  def edit
    @page_title = "Edit Recipe Ingredient"
    @recipe_ingredient = current_recipe.recipe_ingredients.find(params[:id])
    @btnText = "Update Ingredient"
    @obj = @recipe_ingredient
    render 'shared/form'
  end
  
  ##############################################################################
  # Updates recipe ingredient for the current recipe
  #
  # Entry: id is recipe_ingredient id 
  #
  #  Exit: recipe_ingredient updated
  ##############################################################################
  def update
    @recipe_ingredient = current_recipe.recipe_ingredients.find(params[:id])
    @obj = @recipe_ingredient
    if(@recipe_ingredient.update(ri_params))
      flash.alert = "Record Updated"
      redirect_to current_recipe
    else
      flash.now.alert = "Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Deletes recipe ingredient for the current recipe
  #
  # Entry: id is recipe_ingredient id
  #
  #  Exit: recipe_ingredient deleted
  ##############################################################################
  def destroy
    current_recipe.recipe_ingredients.find(params[:id]).destroy
    flash.alert = "Ingredient Removed"
    redirect_to current_recipe
  end
  
#PRIVATE########################################################################
  private
    ############################################################################
    # Allows only permitted parameters to be submitted and used on the pages
    ############################################################################
    def ri_params
      params.require(:recipe_ingredient).permit(:quantity, 
                                                :text, 
                                                :ingredient_id,
                                                :measurement_id)
    end
end

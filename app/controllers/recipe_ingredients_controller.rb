class RecipeIngredientsController < ApplicationController
  
  def new
    init
    @recipe_ingredient = @recipe.recipe_ingredients.new
    @ingredients = Ingredient.all
    @measurements = Measurement.all
  end
  
  def create
    init
    if @recipe_ingredient = @recipe.recipe_ingredients.create(ri_params)
      flash.alert = "Saved"
      redirect_to [@user, @recipe]
    else
      flash.now.alert = "Error"
      render 'new'
    end
  end
  
  def edit
    init
    @recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    @ingredients = Ingredient.all
    @measurements = Measurement.all
  end
  
  def update
    init
    @recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    if(@recipe_ingredient.update(ri_params))
      flash.alert = "Record Updated"
      redirect_to [@user, @recipe]
    else
      flash.now.alert = "Error"
      render 'edit'
    end
  end

=begin  
  def show
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_ingredients = @recipe.recipe_ingredients.find(params[:id])
    @ingredient = @recipe_ingredients.ingredient.find(recipe_ingredient.ingredient_id)
    #@measurement = Measurement.find(params[:ingredient_id])
  end
  
  def index
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipe_ingredients = @recipe.recipe_ingredients.find(params[:id])
    @ingredient = Ingredient.find(params[:ingredient_id])
  end
=end  
  def destroy
    init
    @recipe_ingredient = @recipe.recipe_ingredients.find(params[:id])
    @recipe_ingredient.destroy
    flash.alert = "Ingredient Removed"
    redirect_to [@user, @recipe]
  end
  
  
  
  #############################################################################
  private
    def ri_params
      params.require(:recipe_ingredient).permit(:quantity, :text, :ingredient_id, :measurement_id)
    end
    
    def init
      @user = User.find(session[:user_id])
      @recipe = @user.recipes.find(session[:recipe_id])
    end
end

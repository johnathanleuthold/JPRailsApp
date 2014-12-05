class RecipesController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.new
  end
  
  def create
    @user = User.find(params[:user_id])
    if @recipe = @user.recipes.create(recipe_params)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to user_path(@user)
  end
  
  def edit
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    if(@recipe.update(recipe_params))
      flash.alert = "Recipe updated"
      redirect_to @user
    else
      flash.now.alert = "Error"
      render 'edit'
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @recipes = @user.recipes.find.all#(params[:user_id])
  end
  
  def show
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])
    set_recipe(params[:id])
  end
  
###################################################################################  
  private
    def recipe_params
      params.require(:recipe).permit(:name)
    end
    
end
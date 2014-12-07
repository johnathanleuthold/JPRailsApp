class RatingsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @rating = @recipe.ratings.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @rating = @recipe.ratings.new(rating_params)
    @rating.user_id = current_user.id
    if(@rating.save)
      update_recipe(@recipe.id)
      flash.alert = "Rating added"
      redirect_to [@user, @recipe]
    else
      flash.now.alert = "Error"
      render 'new'
    end
  end
  
  def index
    @ratings = Rating.all
  end

  def edit
  end

  def show
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @rating = @recipe.ratings.find(params[:id])
  end

  def index
    @ratings = Rating.all
  end

################################################################################
  private
  
    def rating_params
      params.require(:rating).permit(:vote, :user_id, :recipe_id)
    end
    
    def update_recipe(recipe_id)
      @recipe = Recipe.find(recipe_id)
      @ratings = @recipe.ratings.all
      @recipe.rating = @ratings.sum(:vote)/@ratings.count
      @recipe.save
    end
    
end


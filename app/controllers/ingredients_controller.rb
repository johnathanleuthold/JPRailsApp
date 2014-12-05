class IngredientsController < ApplicationController
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ing_params)
    if(@ingredient.save)
      flash.alert = "Ingredient Added"
      redirect_to new_ingredient_path
    else
      flash.now.alert = "Problem inserting ingredient"
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def index
    @ingredients = Ingredient.all
  end
  
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end
  
  def show
    @ingredient = Ingredient.find(params[:id])
  end
  
  #######################################################################
  private
    def ing_params
      params.require(:ingredient).permit(:name)
    end
end

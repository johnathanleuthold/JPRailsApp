class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new
  end

  def create
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)
    @comment.user_id = current_user.id
    if(@comment.save)
      flash.alert = "New Comment"
      redirect_to [@user, @recipe]
    else
      flash.now.alert = "Error"
      render 'new'
    end
  end
  
  def edit
    find_comment
  end
  
  def update
    find_comment
    if(@comment.update(comment_params))
      redirect_to [@user, @recipe]
    else
      render 'edit'
    end
  end
  
  def index
   #@user = User.find(params[:user_id])
   @comments = Comment.all
  end

  def show
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.find(params[:id])
  end
  
  
  
  #########################################################################
  private
    def comment_params
      params.require(:comment).permit(:text, :user_id, :recipe_id)
    end
    
    def page_init
      @user = User.find(params[:user_id])
      @recipe = @user.recipes.find(params[:recipe_id])
    end
    
    def find_comment
      page_init
      @comment = @recipe.comments.find(params[:id])
    end
end

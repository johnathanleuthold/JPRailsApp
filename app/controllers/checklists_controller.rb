################################################################################
#Author: Chad Greene
#Date: 12-13-14
#Modifications: 
#Description: The Checklists controller allows users to post 1 or many checklists
#to an individual recipes.
################################################################################
class ChecklistsController < ApplicationController
  
  ##############################################################################
  # Builds a new checklist to store in the database
  #
  # Entry: none
  #
  #  Exit: none
  ##############################################################################
  def new
    @page_title = "New Checklist Item"
    @checklist = current_recipe.checklists.build
    @btnText = "Create Checklist Item"
    @obj = @checklist
    render 'shared/form'
  end
  
  ##############################################################################
  # Builds a checklist from the allowed page parameters.  If save was successful
  # user is directed back to the recipe they were on otherwise the user is 
  # allowed to fix errors on the checklist page and re-submit
  #
  # Entry: dirty form
  #
  #  Exit: form information saved to database
  ##############################################################################
  def create
    @checklist = current_recipe.checklists.build(checklist_params)
    @obj = @checklist
    if(@checklist.save)
      flash.alert = "Added Checklist Item"
      redirect_back_or current_recipe
    else
      flash.now.alert = "Form Error"
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Finds a users checklist from the current recipe to display on view.
  #
  # Entry: :verify_user
  #
  #  Exit: none
  ##############################################################################  
  def edit
    @page_title = "Edit Checklist Item"
    @checklist = current_recipe.checklists.find(params[:id])
    @btnText = "Update Checklist Item"
    @obj = @checklist
    render 'shared/form'
  end

  ##############################################################################
  # Updates checklist with new page parameters
  #
  # Entry: :verify_user
  #
  #  Exit: returns to current_recipe if successful
  #        or allows user to fix errors on the form
  ##############################################################################
  def update
    @checklist = current_recipe.checklists.find(params[:id])
    @obj = @checlist
    if(@checklist.update(checklist_params))
      redirect_back_or current_recipe
    else
      render 'shared/form'
    end
  end
  
  ##############################################################################
  # Deletes a user checklist from the current recipe
  #
  # Entry: :verify_user
  #
  #  Exit: checklist deleted
  ##############################################################################
  def destroy
    current_recipe.checklists.find(params[:id]).destroy
    redirect_back_or current_recipe
  end
  
  ##############################################################################
  # Builds a list of all checklists
  #
  # Entry: :admin_user
  #
  #  Exit: none
  ##############################################################################
  def index
    redirect_to root_url unless admin
    @page_title = "All checklist items"
    @checklists = Checklist.all
  end
  
#PRIVATE########################################################################
  private
    ############################################################################
    # Allows only permitted parameters to be submitted and used on the pages
    ############################################################################
    def checklist_params
      params.require(:checklist).permit(:description, :order, :recipe_id)
    end
end

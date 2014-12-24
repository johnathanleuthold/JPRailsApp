class RecipeIngredient < ActiveRecord::Base
    
    #Relationships
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :measurement
end

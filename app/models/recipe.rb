class Recipe < ActiveRecord::Base
    #Relationships
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :checklists, dependent: :destroy
  
  validates_uniqueness_of :name, scope: :user, on: :create
  
  default_scope -> { order(user_id: :asc, rating: :desc) }
end

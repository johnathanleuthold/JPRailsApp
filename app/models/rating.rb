class Rating < ActiveRecord::Base
    #Relationships
  belongs_to :user
  belongs_to :recipe
end

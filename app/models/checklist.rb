class Checklist < ActiveRecord::Base
  belongs_to :recipe
  has_many :checklist_pictures
end

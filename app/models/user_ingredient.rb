class UserIngredient < ActiveRecord::Base
  belongs_to :user
  belongs_to :ingredient
  
  validates_numericality_of :qty
  
end

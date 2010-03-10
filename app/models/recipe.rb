class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_many :recipe_ratings
  has_many :recipe_comments
  has_many :recipe_instructions
end
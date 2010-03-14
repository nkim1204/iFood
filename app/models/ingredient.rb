class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category
  
  has_many :recipe_ingredients
  has_many :recipies, :through => :recipe_ingredients
  has_many :users, :through => :user_ingredients

  #define_index do
  #  indexes name, :sortable => true  
  #end

end

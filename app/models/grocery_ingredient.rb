class GroceryIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :user
  
  validates_numericality_of :qty

  define_index do
    indexes unit
    has user_id, ingredient_id
  end
end

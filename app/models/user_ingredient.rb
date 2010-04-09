class UserIngredient < ActiveRecord::Base
  belongs_to :user
  belongs_to :ingredient
  
  validates_numericality_of :qty

  define_index do
    indexes unit
    has user_id, ingredient_id
    set_property :delta => true
  end
end

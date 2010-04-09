class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  define_index do
    indexes unit
    has recipe_id, ingredient_id
    set_property :delta => true
  end
end

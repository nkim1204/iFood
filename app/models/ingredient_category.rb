class IngredientCategory < ActiveRecord::Base
  has_many :ingredients
end

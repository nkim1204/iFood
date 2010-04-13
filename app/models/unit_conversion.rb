class UnitConversion < ActiveRecord::Base
  belongs_to :recipe_ingredient
  belongs_to :user_ingredient
end

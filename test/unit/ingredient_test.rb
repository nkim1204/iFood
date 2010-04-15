require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def test_validates_presence_of_name
    ingredient = Ingredient.new
    assert !ingredient.save
  end
end

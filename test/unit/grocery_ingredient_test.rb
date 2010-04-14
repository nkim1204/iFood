require 'test_helper'

class GroceryIngredientTest < ActiveSupport::TestCase
  
  def test_validates_numericality_of_qty
    gi = GroceryIngredient.new
    assert !gi.save
  end
end

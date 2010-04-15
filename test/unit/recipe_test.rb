require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def test_validates_presence_of_title
    recipe = Recipe.new
    assert !recipe.save
  end

  def test_validates_numericality_of_prep_time
    recipe = Recipe.new
    assert !recipe.save
  end
end

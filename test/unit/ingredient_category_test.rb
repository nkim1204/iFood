require 'test_helper'

class IngredientCategoryTest < ActiveSupport::TestCase
  
  def test_validates_presence_of_name
    ic = IngredientCategory.new
    assert !ic.save
  end
  
end

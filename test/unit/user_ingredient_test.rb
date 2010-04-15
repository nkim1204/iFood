require 'test_helper'

class UserIngredientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_validates_numericality_of_qty
    ui = UserIngredient.new
    assert !ui.save
  end
end

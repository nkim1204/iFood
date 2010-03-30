class AdminController < ApplicationController
  before_filter :admin_required
  def index
    @unapproved_recipes = Recipe.find_all_by_approved(false)
    logger.debug @unapproved_recipes.inspect
  end
end

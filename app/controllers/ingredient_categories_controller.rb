class IngredientCategoriesController < ApplicationController
  def index
    @ingredient_categories = IngredientCategory.find(:all)
  end
  
  def new
    @ingredient_category = IngredientCategory.new
  end
  
  def create
    @ingredient_category = IngredientCategory.new(params[:ingredient_category])
    respond_to do |format|
      if @ingredient_category.save
        format.js
      else
        render :action => 'new'
      end
    end
  end
  
  def destroy
    @ingredient_category = IngredientCategory.find(params[:id])
    unless @ingredient_category.destroy
      flash[:error] = "Error Deleting Ingredient Category"
      redirect_to :action => 'index'
    end
  end
  
  def show
    @ingredient_category = IngredientCategory.find(params[:id])
    @ingredients = @ingredient_category.ingredients
  end
end

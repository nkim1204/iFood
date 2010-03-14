class IngredientCategoriesController < ApplicationController
  def index
    @ingredient_categories = IngredientCategory.find(:all)
  end
  
  def new
    @ingredient_category = IngredientCategory.new
  end
  
  def create
    @ingredient_category = IngredientCategory.new(params[:ingredient_category])
    @ingredient_category.save    
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
  
  def edit
    @ingredient_category = IngredientCategory.find(params[:id])
  end
  
  def update
    @ingredient_category = IngredientCategory.find(params[:id])
    @ingredient_category.update_attributes(params[:ingredient_category])
    @ingredient_category.save
  end
end

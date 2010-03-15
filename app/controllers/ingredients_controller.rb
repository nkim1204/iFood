class IngredientsController < ApplicationController
  before_filter :admin_required, :except => [:show]
  def show
    @ingredient = Ingredient.find(params[:id])
  end
  
  def create
    @ingredient_category = IngredientCategory.find(params[:ingredient][:ingredient_category_id])
    @ingredient = Ingredient.new(params[:ingredient])
    @ingredient.save
  end
  
  def new
    @ingredient_category = IngredientCategory.find(params[:id])
    @ingredient = Ingredient.new
  end
  
  def destroy
    @ingredient = Ingredient.find(params[:id])
    unless @ingredient.destroy
      flash[:error] = "Error Deleting Ingredient"
      redirect_to :action => 'index'
    end
  end
  
  def edit
    @ingredient = Ingredient.find(params[:id])
  end
  
  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update_attributes(params[:ingredient])
    @ingredient.save
  end
end

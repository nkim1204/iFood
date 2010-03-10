class IngredientsController < ApplicationController
  
  def show
    @ingredient = Ingredient.find(params[:id])
  end
  
  def create
    @ingredient = Ingredient.new(params[:ingredient])
    respond_to do |format|
      if @ingredient.save
        format.js
      else
        render :action => 'new'
      end
    end
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
end

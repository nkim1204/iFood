class RecipesController < ApplicationController
  
  def new
    @recipe = Recipe.new
    @recipe_instruction = @recipe.recipe_instructions.new()
  end
  
  def add_instruction
    @recipe_instruction = RecipeInstruction.new()
  end

  def approve
    @recipe = Recipe.find(params[:id])
    @recipe.update_attribute(:approved, true)
    flash[:notice] = "Recipe Successfully Approved"
    redirect_to :action => 'show', :id => @recipe.id
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "Successfully Deleted Recipe"
    redirect_to :controller => 'admin', :action => 'index'
  end
  
  def create
    @recipe = Recipe.new(params[:recipe])
    
    ingredients_array = params[:ingredients].split(",")
  	for ingredient_string in ingredients_array
  	  
  	    ingredient = Ingredient.find_by_id(ingredient_string)
	      
  	    if ingredient.nil?
   	      #@error = "Sorry, we don't know that mountain: " + mountain_string
        else
          @error = ""
          @recipe.ingredients << ingredient unless @recipe.ingredients.include?(ingredient)
        end
  	end
  	
  	params[:recipe_instruction].each { |p| @recipe.recipe_instructions << RecipeInstruction.new( p ) }
  	
  	if @recipe.save
  	  redirect_to :action => 'show', :id => @recipe.id
	  else
      @recipe_instruction = @recipe.recipe_instructions.new()
	    render :action => 'new'
	  end
  end
  
  def show
    
    @recipe = Recipe.find(params[:id])

  end
  
  def comment
    @recipe_comments = RecipeComment.new(:recipe_id => params[:id], :user_id => current_user.id, :comment => params[:comment][:body])
     if @recipe_comments.save
     flash[:notice] = "Your comment has been added."
   end 
     redirect_to :action => "show", :id => params[:id]
  end
end

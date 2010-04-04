class RecipesController < ApplicationController
  before_filter :login_required, :except => [:show]
  def new
    @recipe = Recipe.new
    @recipe_instruction = @recipe.recipe_instructions.new()
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_instruction = @recipe.recipe_instructions.find_by_recipe_id(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])

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
  	
  	if @recipe.update_attributes(params[:recipe])
  	  redirect_to :action => 'show', :id => @recipe.id
	  else
      @recipe_instruction = @recipe.recipe_instructions.new()
	    render :action => 'new'
	  end
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
  	  admin = User.find_by_is_admin(true)
  	  UserMailer.deliver_new_recipe(admin, @recipe)
  	  redirect_to :action => 'show', :id => @recipe.id
	  else
      @recipe_instruction = @recipe.recipe_instructions.new()
	    render :action => 'new'
	  end
  end
  
  def show
    
    @recipe = Recipe.find(params[:id])
    @recipe_comments = @recipe.recipe_comments;
    @recipe_ratings = @recipe.recipe_ratings;
    @recipe_avg_rating = avg_rating()
  end

  def avg_rating
    ratings = RecipeRating.all(:conditions => ["recipe_id =?", params[:id]], :select => "rating")
    rating_sum = 0
    for r in ratings
        rating_sum = rating_sum + r.rating
    end

    res = 0
    if ratings.size != 0
        res = rating_sum / ratings.size
    end
    return res
  end

  def rate
    @recipe_ratings = RecipeRating.new(:recipe_id => params[:id], :user_id => current_user.id, :rating => params[:rate][:rating].to_i )
    if @recipe_ratings.save
      flash[:notice] = "Your rating has been saved."
    end 
	redirect_to :action => 'show', :id => params[:id]
  end
  
  def comment
    @recipe_comments = RecipeComment.new(:recipe_id => params[:id], :user_id => current_user.id, :comment => params[:comment][:body])
    if @recipe_comments.save
      flash[:notice] = "Your comment has been added."
    end 
    redirect_to :action => "show", :id => params[:id]
  end

  def destroy_comment
    @recipe_comment = RecipeComment.find(params[:id])
    unless @recipe_comment.destroy
      flash[:error] = "Error Deleting Comment"
      redirect_to :action => 'show'
    end
  end
end

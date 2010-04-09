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
  
  #BUG:  doesn't check to make sure only one of each item is in the grocery list
  #BUG:  doesn't account for if serving qty was changed
  #BUG:  when render the page again doesn't keep in memory the serving qty
  def add_to_grocery_list
  item_ids = Array.new
   params[:grocery].each_pair{|k, v| item_ids << k if  v == "1" }
    
    item_ids.each do |item|
      puts "#{item} is to be added to the grocery list"
      @grocery_ingredient = GroceryIngredient.new()
      @grocery_ingredient.user_id = current_user.id
      @grocery_ingredient.ingredient_id = item.to_i
      rec_ing = RecipeIngredient.find(:first, :conditions => ["recipe_id = #{params[:id]} AND ingredient_id = #{item}"])
      @grocery_ingredient.qty = rec_ing.qty
      @grocery_ingredient.unit = rec_ing.unit
      if @grocery_ingredient.save
        flash[:notice] = "Items were successfully added to your grocery list"
      else 
        flash[:warning] = "Items were not added to your grocery list - something went wrong.  We are currently trying to fix this problem.  Sorry for any inconvenience"
      end 
    end
    redirect_to :action => 'show', :id => params[:id] 
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
    @recipe_comments = @recipe.recipe_comments
    @recipe_ratings = @recipe.recipe_ratings
    @recipe_avg_rating = avg_rating()
    if @serving_qty.nil?
      @serving_qty = @recipe.serving_qty
    end
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
    r = RecipeRating.all(:conditions => ["recipe_id = ? AND user_id = ?", params[:id], current_user.id])
    msg = "Your rating has been saved."
    if r.size != 0 
        @recipe_ratings = RecipeRating.update( r.first.id, :rating => params[:rate][:rating].to_i )
        msg = "Your rating has been updated."
    else
         @recipe_ratings = RecipeRating.new(:recipe_id => params[:id], :user_id => current_user.id, :rating => params[:rate][:rating].to_i )
    end
    if @recipe_ratings.save
      flash[:notice] = msg
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
  
  def adjust_ingredient_amt
    @recipe = Recipe.find(params[:id])
    @recipe_comments = @recipe.recipe_comments
    @recipe_ratings = @recipe.recipe_ratings
    @recipe_avg_rating = avg_rating()
    @serving_qty = params[:new_qty][:qty].to_i()
    render :action => 'show'
  end
end

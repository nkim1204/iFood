class SearchController < ApplicationController
  
  def show
    @results = Array.new()
	# here we're searching for the search word in the recipe title
	if params[:search]
    q = params[:search][:query]
    @searchfor = q
	if params[:search][:type] == "title"
	        ids = Array.new( Recipe.search_for_ids(q) )
		for recipe in Recipe.find(ids)
			@results << recipe
		end	
		#@results = Recipe.find(ids).title
    # here we're searching for recipes with the given ingredient
    elsif params[:search][:type] == "ingredient"
		id = Array.new(Ingredient.search_for_ids(q)) 
        # grab the associated recipe_ids
        #rids = Array.new()
        #for id in iids

        # for now, selecting first returned search result id[0]
        RecipeIngredient.all(:select => "recipe_id", :conditions => { :ingredient_id => id[0] }).each do |rid|
            @results << rid.recipe
        end

        #@results << RecipeIngredient.all(:select => "recipe_id", :conditions => { :ingredient_id => id }).first.recipe
                
	end	
		end
		
  end
  
end

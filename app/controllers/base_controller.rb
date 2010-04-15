class BaseController < ApplicationController

  def index

    if current_user
    #The array in which we will store our final search results and pass on to the view to render
      temp_hash = Hash.new("Recipe doesn't exist in hash")

      #The current user id
      cur_uid = current_user.id

      #Search the user_ingredients table and get the corresponding ingredients associated with the current user
      #This will return an array, with each element being a row in the UserIngredient table
      user_ingredients = UserIngredient.find(:all, :conditions => ["user_id = ?", cur_uid])      

      #Loop through the array.  For each iteration:
      #1.  Grab the ingredient ID in the row
      #2.  Search the recipe_ingredient table for corresponding recipes
      #3.  In the array returned from 2, for each recipe, store in a hash:  key = RID value = matching ingredients
      #3b.      If key exists, value ++

      for user_ingredient_row in user_ingredients

        #The ingredient in the user's kitchen that we are currently looking at
        current_ingredient = user_ingredient_row.ingredient_id

        #Search the recipe_ingredient table for recipes having the current_ingredient
        recipe_ingredient_rows = RecipeIngredient.find(:all, :conditions => ["ingredient_id = ?", current_ingredient])

        #loop through recipe_ingredient_rows, and store recipes in our auto_results hash (Key = recipe_id, Value = # matching ingredients)
        for recipe_ingredient_row in recipe_ingredient_rows

          #if our recipe_id key is not in our hash, create new hash entry
          if !temp_hash.has_key?(recipe_ingredient_row.recipe_id)
            temp_hash[recipe_ingredient_row.recipe_id] = 1

            #Otherwise, the recipe already exists in our hash, and all we have to do is increment the number of matching ingredients
          else
            temp_value = temp_hash[recipe_ingredient_row.recipe_id]
            temp_hash[recipe_ingredient_row.recipe_id] = temp_value + 1
          end

        end

      end

      @auto_results = temp_hash.to_a
    end

  end


end

class GroceryIngredientsController < ApplicationController
  # GET /grocery_ingredients
  # GET /grocery_ingredients.xml
  before_filter :login_required
  def index
    @grocery_ingredients = GroceryIngredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grocery_ingredients }
    end
  end

  # GET /grocery_ingredients/1
  # GET /grocery_ingredients/1.xml
  def show
    @grocery_ingredient = GroceryIngredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grocery_ingredient }
    end
  end
  
  def show_items
      @ingredient_category = IngredientCategory.find(params[:id])
      @dummy_tag = true
  end

  def add
    @grocery_ingredient = GroceryIngredient.find_by_ingredient_id(params[:id])
    @ingredient = Ingredient.find(params[:id])
    if @grocery_ingredient.nil?
      @grocery_ingredient = GroceryIngredient.new(:user_id => current_user.id, :ingredient_id => params[:id])
      session[:ingredient_id] = params[:id]
    end
    #render :partial => 'add'
  end
  
  # GET /grocery_ingredients/new
  # GET /grocery_ingredients/new.xml
  def new
    #@user_ingredient = UserIngredient.new
    @ingredient_categories = IngredientCategory.find(:all)
    #render :partial => 'new'
  end

  # GET /grocery_ingredients/1/edit
  def edit
    @grocery_ingredient = GroceryIngredient.find(params[:id])
  end

  # POST /grocery_ingredients
  # POST /grocery_ingredients.xml
  def create
    @grocery_ingredient = GroceryIngredient.new(params[:grocery_ingredient])
    @grocery_ingredient.user_id = current_user.id
    @grocery_ingredient.ingredient_id = session[:ingredient_id]
    session[:ingredient_id] = nil
    #@grocery_ingredient.ingredient_id = @ingredient
    respond_to do |format|
      if @grocery_ingredient.save
        flash[:notice] = 'Ingredient was successfully added to your grocery list.'
        format.html { redirect_to(@grocery_ingredient) }
        format.xml  { render :xml => @grocery_ingredient, :status => :created, :location => @grocery_ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grocery_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grocery_ingredients/1
  # PUT /grocery_ingredients/1.xml
  def update
    @grocery_ingredient = GroceryIngredient.find(params[:id])
    respond_to do |format|
      if @grocery_ingredient.update_attributes(params[:grocery_ingredient])
        flash[:notice] = 'Ingredient in grocery list was successfully updated.'
        format.html { redirect_to(@grocery_ingredient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grocery_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #BUG: view doesn't update after addition
  #BUG: view looks strange with add there
  #BUG: doesn't check to make sure only one item in user_ingredients table
  def grocery_to_user
    @grocery_ingredient = GroceryIngredient.find(params[:id])
    @user_ingredient = UserIngredient.new
    @user_ingredient.user_id = current_user.id
    @user_ingredient.ingredient_id = @grocery_ingredient.ingredient_id
    @user_ingredient.qty = @grocery_ingredient.qty
    @user_ingredient.unit = @grocery_ingredient.unit
    if @user_ingredient.save
      flash[:notice] = "Ingredient was added to your virtual kitchen"
    end
  end

  # DELETE /grocery_ingredients/1
  # DELETE /grocery_ingredients/1.xml
  def destroy
    @grocery_ingredient = GroceryIngredient.find(params[:id])
    @grocery_ingredient.destroy
  end
end
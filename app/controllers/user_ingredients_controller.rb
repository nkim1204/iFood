class UserIngredientsController < ApplicationController
  # GET /user_ingredients
  # GET /user_ingredients.xml
  before_filter :login_required
  def index
    @user_ingredients = UserIngredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_ingredients }
    end
  end

  # GET /user_ingredients/1
  # GET /user_ingredients/1.xml
  def show
    @user_ingredient = UserIngredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_ingredient }
    end
  end
  
  def show_items
      @ingredient_category = IngredientCategory.find(params[:id])
      @dummy_tag = true
  end

  def add
    @user_ingredient = UserIngredient.find_by_ingredient_id(params[:id])
    @ingredient = Ingredient.find(params[:id])
    if @user_ingredient.nil?
      @user_ingredient = UserIngredient.new(:user_id => current_user.id, :ingredient_id => params[:id])
      session[:ingredient_id] = params[:id]
    end
    #render :partial => 'add'
  end
  
  # GET /user_ingredients/new
  # GET /user_ingredients/new.xml
  def new
    #@user_ingredient = UserIngredient.new
    @ingredient_categories = IngredientCategory.find(:all)
    #render :partial => 'new'
  end

  # GET /user_ingredients/1/edit
  def edit
    @user_ingredient = UserIngredient.find(params[:id])
  end

  # POST /user_ingredients
  # POST /user_ingredients.xml
  def create
    @user_ingredient = UserIngredient.new(params[:user_ingredient])
    @user_ingredient.user_id = current_user.id
    @user_ingredient.ingredient_id = session[:ingredient_id]
    session[:ingredient_id] = nil
    #@user_ingredient.ingredient_id = @ingredient
    respond_to do |format|
      if @user_ingredient.save
        flash[:notice] = 'UserIngredient was successfully created.'
        format.html { redirect_to(@user_ingredient) }
        format.xml  { render :xml => @user_ingredient, :status => :created, :location => @user_ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_ingredients/1
  # PUT /user_ingredients/1.xml
  def update
    @user_ingredient = UserIngredient.find(params[:id])
    respond_to do |format|
      if @user_ingredient.update_attributes(params[:user_ingredient])
        flash[:notice] = 'UserIngredient was successfully updated.'
        format.html { redirect_to(@user_ingredient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # DELETE /user_ingredients/1
  # DELETE /user_ingredients/1.xml
  def destroy
    @user_ingredient = UserIngredient.find(params[:id])
    @user_ingredient.destroy
  end
end

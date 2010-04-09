class Ingredient < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :ingredient_category
  
  has_many :recipe_ingredients
  has_many :recipies, :through => :recipe_ingredients
  has_many :users, :through => :user_ingredients

  define_index do
   indexes name, :sortable => true  
   set_property :delta => true
  end

end

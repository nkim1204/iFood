class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_many :recipe_ratings
  has_many :recipe_comments
  has_many :recipe_instructions

  validates_presence_of :title
  validates_numericality_of :prep_time
  
  has_attached_file :photo, :default_url => "/images/default.jpg",
    :styles => {
      :thumb=> "50x50#",
      :small  => "150x150>",
      :medium => "300x300>",
      :large =>   "400x400>" }
  
  define_index do
    indexes title, :sortable => true
 #   indexes recipe.ingredients.name, :as => :ingredient, :sortable => true
    has prep_time, id
  end
  
end

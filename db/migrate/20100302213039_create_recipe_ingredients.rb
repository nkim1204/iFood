class CreateRecipeIngredients < ActiveRecord::Migration
  def self.up
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id 
      t.float :qty 
      t.string :unit
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_ingredients
  end
end

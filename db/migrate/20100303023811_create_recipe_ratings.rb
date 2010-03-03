class CreateRecipeRatings < ActiveRecord::Migration
  def self.up
    create_table :recipe_ratings do |t|
      t.int :recipe_id
      t.int :user_id
      t.int :rating
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_ratings
  end
end

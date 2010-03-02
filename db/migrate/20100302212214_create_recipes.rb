class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.integer :user_id
      t.string :recipe_photo_path
      t.boolean :approved
      t.text :overview
      t.float :prep_time
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end

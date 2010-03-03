class CreateRecipeInstructions < ActiveRecord::Migration
  def self.up
    create_table :recipe_instructions do |t|
      t.integer :recipe_id
      t.integer :step_num
      t.text :instruction_text
      t.string :instruction_photo_path
      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_instructions
  end
end

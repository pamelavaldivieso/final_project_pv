class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.integer :cuisine_id
      t.string :ingredients
      t.string :directions
      t.string :country_origin
      t.string :name
      t.string :photo

      t.timestamps
    end
  end
end

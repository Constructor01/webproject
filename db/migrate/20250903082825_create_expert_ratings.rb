class CreateExpertRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :expert_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :image, null: false, foreign_key: true
      t.integer :value, null: false
      t.text :comment

      t.timestamps
    end
    add_index :expert_ratings, [:user_id, :image_id], unique: true
  end
end

class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :item_id
      t.text :body
      t.string :item_image_id
      t.float :rate

      t.timestamps
    end
  end
end

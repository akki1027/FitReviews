class AddProfilePhotoIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_photo_id, :string
    add_column :users, :background_photo_id, :string
    add_column :users, :is_deleted, :boolean, default: false
  end
end

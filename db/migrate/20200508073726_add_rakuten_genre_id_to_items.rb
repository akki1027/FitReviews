class AddRakutenGenreIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :rakuten_genre_id, :integer
  end
end

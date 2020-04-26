class AddRakutenItemIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :rakuten_item_id, :string
  end
end

class Item < ApplicationRecord
	has_many :reviews, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	validates :rakuten_item_id, uniqueness: true
	# validates :name, uniqueness: true
end

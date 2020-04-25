class Review < ApplicationRecord
	belongs_to :user
	# belongs_to :item
	validates :body
	validates :rate
	attachment :item_image
end

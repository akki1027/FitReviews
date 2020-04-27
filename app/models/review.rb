class Review < ApplicationRecord
	belongs_to :user
	belongs_to :item
	validates :body, presence: true
	validates :rate, presence: true
	attachment :item_image
end

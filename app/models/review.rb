class Review < ApplicationRecord
	belongs_to :user
	belongs_to :item
	has_many :likes, dependent: :destroy
	validates :body, presence: true
	validates :rate, presence: true
	attachment :item_image
end

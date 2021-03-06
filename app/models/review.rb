class Review < ApplicationRecord
	belongs_to :user
	belongs_to :item
	has_many :likes, dependent: :destroy
	validates :body, presence: true, length: {maximum: 300}
	validates :rate, presence: true
	attachment :item_image
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
	def bookmarked_by?(user)
		bookmarks.where(user_id: user.id).exists?
	end
end

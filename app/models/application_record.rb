class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  	def bookmarked_by?(user)
		bookmarks.where(user_id: user.id).exists?
	end
end

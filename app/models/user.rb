class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  validates :name, presence: true
	attachment :profile_photo
	attachment :background_photo

	# is_deletedカラムがtrueのuser（退会済）をはじく
  	def active_for_authentication?
    	super && (self.is_deleted == false)
  	end
end

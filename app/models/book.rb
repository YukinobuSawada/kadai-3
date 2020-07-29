class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true,length: {maximum:200}
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def following?(other_user)
        following.find_by(following_id: other_user.id)
    end

    def follow!(other_user)
        following.create!(following_id: other_user.id)
    end

    def unfollow!(other_user)
        following.find_by(following_id: other_user.id).destroy
    end
end

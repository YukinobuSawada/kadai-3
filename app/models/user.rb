class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :book_comments,dependent: :destroy
         has_many :following,foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
          has_many :followings, through: :following
          has_many :follower,foreign_key: "following_id",class_name: "Relationship", dependent: :destroy
          has_many :followers, through: :follower

         attachment :profile_image
         validates :name, presence: true,uniqueness: true ,length: {minimum: 2,maximum:20}
         validates :introduction,length:{maximum: 50}


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

        def self.search(search,word)
          if search == "forward_match"
            @user = User.where("name LIKE?","#{word}%")
          elsif search == "backward_match"
            @user = User.where("name LIKE?","%#{word}")
          elsif search == "perfect_match"
            @user = User.where("name LIKE?","#{word}")
          elsif search == "partial_match"
            @user = User.where("name LIKE?","%#{word}%")
          else
            @user = User.all
          end
end
end
class Relationship < ApplicationRecord
	belongs_to :follower, class_name: "User"
	belongs_to :following, class_name: "User"
	validates :follower_id, presence: true
	validates :following_id, presence: true
	def change
		create_table :relationships do |t|
			t.integer :follwer_id
			t.integer :follwing_id
			t.timestamps null: false
		end
		add_index :relationships, :follower_id
		add_index :relationships, :followed_id
    	add_index :relationships, [:follower_id, :following_id], unique: true
    end


end

class User < ActiveRecord::Base
	acts_as_authentic
	validates :name, :presence => true
	validates :email, :presence => true

	has_many :microposts #! One to many

	has_many :relationships, :foreign_key => :follower_id
	has_many :following_users, :through => :relationships, :source => :followed

	has_many :reverse_relations, :class_name => "Relationship", :foreign_key => :followed_id
	has_many :follower_users, :through => :reverse_relations, :source => :follower

	def feed
		#microposts
		monitored_user_id = following_users.map(&:id) << self.id
		Micropost.where(:user_id => monitored_user_id)
	end

	def following?(user_id)
		relationships.find_by_followed_id(user_id)
	end

	#following?
	def follow(user_id)
		relationships.create(:followed_id => user_id)
	end

	def unfollow(user_id)
		relationships.find_by_followed_id(user_id).destroy
	end
end

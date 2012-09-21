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
		microposts
	end
end

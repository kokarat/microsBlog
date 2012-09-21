class Micropost < ActiveRecord::Base
	belongs_to :user #! many to one
	
	#! validate 
	validates :user, :presence => true
	validates :user_id, :presence => true
	validates :content, :presence => true

	#! sort post use method default_scope
	default_scope :order => "created_at DESC"
end

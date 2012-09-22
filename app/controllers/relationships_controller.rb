class RelationshipsController < ApplicationController
	def create
		current_user.follow(params[:relationship][:followed_id])
		redirect_to user_url(params[:relationship][:followed_id])
	end
	def destroy
		current_user.unfollow(params[:relationship][:followed_id])
		redirect_to user_url(params[:relationship][:followed_id])
	end
end

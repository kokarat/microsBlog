class UsersController < ApplicationController

  before_filter :require_login, :except => [:new, :create]
  before_filter :require_not_login, :only => [:new, :create]

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @relationship = Relationship.new
  end

  def new
  	@user = User.new
  end

  def edit
    #@user = User.find(params[:id]) # edit all by params id
    @user = User.find(current_user.id) #edit current user only
  end

  def create
   @user = User.new(params[:user])
   if @user.save
    flash[:notice] = "Sign up successfully."
		redirect_to root_url #! redirect to home 
 else
  		render :action => :new #! render view new
    end
  end

  def update
    #@user = User.find(params[:id])
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile was updated."
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  def follower
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end
  def following
    @user = User.find(params[:id])
    @followings = @user.following_users
  end

end

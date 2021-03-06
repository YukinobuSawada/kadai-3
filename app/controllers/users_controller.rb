class UsersController < ApplicationController
     before_action :authenticate_user! ,   only: [:edit, :update, :index, :show]
     before_action :current_user,   only: [:edit, :update, :index, :show]
	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def index
		@users = User.all
		@user = current_user
		@book = Book.new
	end
	def edit
        @user = User.find(params[:id])
        if @user == current_user
            render "edit"
          else
            redirect_to user_path(current_user)
          end
    end
    def update
    	@user = User.find(params[:id])
    	if @user.update(user_params)
    	redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
    	render :edit
    end
    end

    def following
        @user = User.find(params[:id])
        @users = @user.followings
        render 'show_follow'
    end

    def followers
        @user = User.find(params[:id])
        @users = @user.followers
        render 'show_follower'
    end

    private 
    
    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
class UsersController < ApplicationController
  before_action :require_user, except: [:new,:create]
  before_action :authorize_user, only: [:edit,:update,:destroy]
  before_action :user_admin, only:[:destroy]
	before_action :set_user, only: [:edit,:update,:destroy,:show]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      session[:user_id] = @user.id
			redirect_to @user, notice: 'Thanks for Signing up!!'
		else
			render :new
		end
	end

	def show
    @reviews  =  @user.reviews
    @favourites = @user.favourite_movies
	end

	def edit

	end

	def update
		if @user.update(user_params)
			redirect_to @user
		else
			render :edit, notice: "User Successfully updated!!"
		end
	end

	def destroy
		@user.destroy
    # commenting out as only admin has rights to delete the user
    # Admin user should not logout after he deletes other users
    # account
    # session[:user_id] = nil
		redirect_to root_path, notice: "Account successfully deleted!"
	end


	private 

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation,:username)
  end


end

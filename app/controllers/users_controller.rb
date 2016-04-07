class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update,:show,:index,:likes,:following]
	before_action :correct_user,only: [:edit, :update,:likes,:following]
	before_action :is_admin,only: [:index,:destroy]

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts
		# render :text => @feed.first.id.inspect
		if params[:last]
			@posts = @user.posts_with_last(params[:last])
		else
			@posts = @user.posts.limit(5)
		end
		respond_to do |format|
			format.js
		end


	end

	def edit
	end

	def update
		if user_params
			if @user.update_attributes(user_params)
				flash.now[:success] = "Successfully updated your profile" 
				render 'edit'
			else
				flash.now[:danger] = "fail to update profile"
				render 'edit'
			end
		elsif password_params
			if @user.authenticate(password_params[:old_password])
				if @user.update_attributes({password:password_params[:new_password],password_confirmation:password_params[:new_password_confirmation]})
					flash.now[:success] = "Successfully changed your password"
					render 'edit'
				else
					flash.now[:danger] = "fail to change password"
					render 'edit'
				end
			else
				flash.now[:danger] = "wrong password"
				render 'edit'
			end
		elsif avatar_params || header_params
			@user.update_attributes(avatar_params) if avatar_params
			@user.update_attributes(header_params) if header_params
			respond_to do |format|
				format .js
			
			end
		end

	end
	def index
		@users = User.all
	end
	def destroy
		@user = User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end
	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
      		flash[:info] = "Please check your email to activate your account."
      		session[:user_id] = @user.id 
			@user.remember
			cookies.permanent.signed[:user_id] = @user.id
			cookies.permanent[:remember_token] = @user.remember_token
			redirect_to root_url
		else
			render 'new'
		end
	end

	def delete
	end
	
	def likes
		@user = User.find(params[:id])
		if params[:last]
			@feed = @user.likes.where("like_id < :last",last: params[:last]).limit(5)
		else
			@feed = @user.likes.limit(5)
		end
		respond_to do |format|
			format .js
			format .html 
			
		end
	end

	def following
		@user = User.find(params[:id])
		@following = @user.followings.paginate(page:params[:page],per_page:20)
		# @followers = @user.followers.paginate(page:params[:page],per_page:1)
	end

	private 
	def user_params
		params.require(:user).permit(:email,:password,:password_confirmation,:name,:user_name,:sex,:phone,:websit,:bio) if params[:user]
	end
	
	def password_params
		params.require(:change_password).permit(:old_password,:new_password,:new_password_confirmation) if params[:change_password]
	end

	def avatar_params
		params.require(:change_avatar).permit(:avatar) if params[:change_avatar]
	end

	def header_params
		params.require(:change_header).permit(:header) if params[:change_header]
	end
#before fliter
	def correct_user
		@user = User.find(params[:id])
		unless  @user == current_user
			redirect_to root_url
		end
	end
	def is_admin
		unless current_user.admin?
			redirect_to root_url
		end
	end
	
end

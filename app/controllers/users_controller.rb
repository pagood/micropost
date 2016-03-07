class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update,:show,:index]
	before_action :correct_user,only: [:edit, :update]
	before_action :is_admin,only: [:index,:destroy]

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@feed = @user.posts
		# render :text => @feed.first.id.inspect
		# if params[:last]
		# 	@feed = current_user.feed(params[:last])
		# else
		# 	@feed = current_user.feed_without_params
		# end
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
		elsif avatar_params
			@user.update_attributes(avatar_params)
			respond_to do |format|
				format .js
				format .html 
			
			end
		end

	end
	def index
		@users = User.all
	end
	def destroy
		@user = User.find(params[:id]).destroy
		flash.now[:success] = "User deleted"
		redirect_to users_url
	end
	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
      		flash.now[:info] = "Please check your email to activate your account."
			redirect_to root_url
		else
			render 'new'
		end
	end

	def delete
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

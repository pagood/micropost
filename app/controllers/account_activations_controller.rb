class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated && user.authenticated?(:activation, params[:id])
			user.update_attribute(:activated,true)
			user.update_attribute(:activated_at,Time.zone.now)
			session[:user_id] = user.id 
			user.remember
			cookies.permanent.signed[:user_id] = user.id
			cookies.permanent[:remember_token] = user.remember_token
			flash.now[:success] = "Account activated!"
			redirect_to root_url
		else
			flash.now[:danger] = "Invalid activation link"
			redirect_to root_url
		end
	end
end

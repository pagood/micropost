class SessionsController < ApplicationController
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				session[:user_id] = user.id 
				user.remember
				cookies.permanent.signed[:user_id] = user.id
				cookies.permanent[:remember_token] = user.remember_token
				redirect_back_or '/'
			else
				message  = "Account not activated. "
		        message += "Check your email for the activation link."
		        flash.now[:warning] = message
		        redirect_to root_url
			end
		else
			@msg ||= 'Your email or password were incorrect.'
			render 'new'
		end
	end
	def new
	end
	def destroy
		if logged_in?
			current_user.update_attribute(:remember_digest,nil)
			cookies.delete(:user_id)
			cookies.delete(:remember_token)
			session.delete(:user_id)
		end
		redirect_to '/'
	end

end

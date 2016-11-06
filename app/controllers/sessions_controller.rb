class SessionsController < ApplicationController
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])

				session[:user_id] = user.id 
				user.remember
				cookies.permanent.signed[:user_id] = user.id
				cookies.permanent[:remember_token] = user.remember_token
				redirect_back_or root_url
		else
			@msg ||= 'Your email or password were incorrect.'
			render 'new'
		end
	end

	def create_for_vistor
		user = User.find_by_email('hello@vistor.com')
		session[:user_id] = user.id 
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
		redirect_back_or root_url
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
		redirect_to root_url
	end

end

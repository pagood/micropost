class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,:logged_in?,:radar,:recommended_users
  protect_from_forgery with: :null_session
  def current_user
  	if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(:remember,cookies[:remember_token])
        session[:user_id] = user.id 
        @current_user = user
      end
    end

  end
    
  def logged_in?
  	!current_user.nil?
  end
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to '/login'
    end
  end

  def recommended_users
    @recommended_users = current_user.recommended_users
  end

  def radar
    @radar = Post.find_by("photo IS NOT NULL")
  end
end

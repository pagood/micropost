class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,:logged_in?,:radar,:recommended_users,:find_conversation,:is_activated?
  
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
    
  def is_activated?
    unless current_user.activated? 
      flash[:info] = "Please check your email to activate your account."
      redirect_to '/'
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

  def recommended_users(num = 4)
    @recommended_users = current_user.recommended_users(num)
  end

  def next_recommended_user(last)
    current_user.next_recommended_user(last)
  end

  def radar
    @radar = Post.find_by("photo IS NOT NULL")
  end

  def find_conversation(user1,user2)
    if Conversation.find_by(sender_id:user1.id,receiver_id:user2.id) 
      Conversation.find_by(sender_id:user1.id,receiver_id:user2.id)
    else 
      Conversation.find_by(sender_id:user2.id,receiver_id:user1.id)
    end
  end
  def handle_mobile
    request.format = :mobile if mobile_user_agent?
  end

  def mobile_user_agent?
    @mobile_user_agent ||= ( request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/] )
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    # ||= is memoization to not recheck the user in the database
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to recipes_path
    end
  end
  
  def admin_user
    redirect_to recipes_path unless current_user.admin?
  end
  
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user


  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authorize_admin!
  	if current_user
  		true
  	else
  		flash[:error] = "You are not authorized to view this content!"
  		redirect_to root_path
  	end
  end
end

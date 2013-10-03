class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user


  private

  # this method allows to use current_user helper to determine if user is logged in or not and who the user is (if logged)
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # this method is use to authorize user's access to restricted actions (:new, :create, :destroy, :update)
  def authorize_admin!
  	if current_user
  		true
  	else
  		flash[:error] = "You are not authorized to view this content!"
  		redirect_to root_path
  	end
  end
end

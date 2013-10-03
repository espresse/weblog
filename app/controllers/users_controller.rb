class UsersController < ApplicationController
	def index
		@users = User.order(:id).page params[:page]
	end
	
	def show
		@user = User.find(params[:id])
		@posts = @user.posts.page params[:page]
	end

    def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
	    redirect_to root_url, notice: "Signed up!"
	  else
	    render "new"
	  end
	end

	private
	def user_params
	  params.require(:user).permit(:email, :password, :password_confirmation, :username)
	end
end

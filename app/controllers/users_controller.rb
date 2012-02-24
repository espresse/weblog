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
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end
end

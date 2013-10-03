class Admin::PostsController < ApplicationController
	layout "admin"
	before_filter :authorize_admin!, except: [:index]
	before_filter :find_post, only: [:edit, :update, :destroy]

	def index
		@posts = current_user.posts.ordered.page params[:page]
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			flash[:notice] = "The post has been updated."
			redirect_to @post
		else
			flash[:error] = "Post could not be save."
			render :new
		end
	end

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			flash[:notice] = "The post has been updated."
			redirect_to @post
		else
			flash[:error] = "Post could not be save."
			render :new
		end
	end

	def destroy
		if @post.destroy
			flash[:notice] = "The post has been deleted."
			redirect_to admin_posts_path
		else
			flash[:error] = "Post could not be deleted."
			render :new
		end
	end

	private

	def find_post
		begin
			@post = current_user.posts.find(params[:id])
		rescue
			flash[:error] = "You are not allowed to manage this post"
			redirect_to admin_posts_path
		end
	end

	private
	def post_params
	  params.require(:post).permit(:title, :content, :tag_list)
	end

end

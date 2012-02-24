class PostsController < ApplicationController
	before_filter :find_post, :only => [:show, :edit, :update, :destroy]

	def index
		@posts = Post.order('created_at DESC').page params[:page]
	end

	def show
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.new(params[:post])
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
		if @post.update_attributes(params[:post])
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
			redirect_to @post
		else
			flash[:error] = "Post could not be deleted."
			render :new
		end	
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	
end

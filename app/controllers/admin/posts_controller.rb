class Admin::PostsController < ApplicationController
	layout "admin"
	before_filter :authorize_admin!, :except => [:index, :show]
	before_filter :find_post, :only => [:show, :edit, :update, :destroy]
	
	def index
		@posts = current_user.posts.order('created_at DESC').page params[:page]
	end

	def show
		redirect_to @post
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

end
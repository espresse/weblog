class CommentsController < ApplicationController
	before_filter :find_post
	respond_to :html, :js

	def new
		@comment = @post.comments.build
	end

	def create
		@comment = @post.comments.new(params[:comment])
		@comment.user = current_user if current_user
		if @comment.save
			flash[:notice] = "The comment has been added."
			redirect_to @post
		else
			render :new
		end
	end

	private

	def find_post
		@post = Post.find(params[:post_id])
	end
end

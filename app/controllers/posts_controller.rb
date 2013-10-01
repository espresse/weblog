class PostsController < ApplicationController
	before_filter :authorize_admin!, except: [:index, :show]
	before_filter :find_post, only: [:show, :edit, :update, :destroy]
	
	def index
		@posts = Post.order('created_at DESC').page params[:page]
	end

	def show
	end


	private

	def find_post
		@post = Post.find(params[:id])
	end

end

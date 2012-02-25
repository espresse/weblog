class TagsController < ApplicationController

	def index
		@tags = Tag.all
	end

	def show
		@tag = Tag.find_by_name(params[:id])
		@posts = @tag.posts.order(:id).page params[:page] rescue []
		if @post.blank?
			@tags = Tag.order("name ASC")
		end
	end

	def search
		redirect_to tag_path(:id => params[:s])
	end
	
end

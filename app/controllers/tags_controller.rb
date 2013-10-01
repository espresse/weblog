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

	#an action used for search. Actually it's a redirection to show action, so after performing search 
	#user get nice looking http address
	def search
		redirect_to tag_path(id: params[:s])
	end
	
end

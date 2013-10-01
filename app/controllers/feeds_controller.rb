class FeedsController < ApplicationController
  
  layout false
  
  # well... I prefer atom over rss so, all rss request are going to parse atom. 
  # this doesn't affect end-user experience :)
  def index
    @posts = Post.limit 50
    @title = "Weblog - last posts"
    @updated = @posts.first.created_at unless @posts.empty?
    respond_to do |format|
      format.rss do
        redirect_to feeds_path(format: :atom),
                    status: :moved_permanently
      end
      format.atom
    end
  end
end
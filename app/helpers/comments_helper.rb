module CommentsHelper
	def last_comments
		Comment.order('created_at DESC').limit(5)
	end
end

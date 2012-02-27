module CommentsHelper
	#this helper is used in application layout. We need to find lat 5 comments...
	#an ideal place for such helper would be in decorator or preseter pattern but for such a simple app 
	#it's not the best idea

	def last_comments
		Comment.order('created_at DESC').limit(5)
	end
end

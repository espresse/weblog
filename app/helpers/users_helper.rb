module UsersHelper
	#this helper is used in application layout. We need to find lat 5 active users...
	#an ideal place for such helper would be in decorator or preseter pattern but for such a simple app 
	#it's not the best idea
	def active_authors
		User.active_5
	end
end

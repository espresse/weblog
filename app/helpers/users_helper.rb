module UsersHelper
	def active_authors
		User.active_5
	end
end

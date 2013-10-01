class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :username, presence: true
	validates :content, presence: true, length: { minimum: 2 }

	valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email, presence: true, format: { with: valid_email_regex }

	before_validation :set_user

	private
	#comment needs an author. If the author is anonymous fields username and content had to be filled in.
	#validation here helps to detect if this actually is true.
	#In case of author being logged in user there is no need to fill-in username and email again and again
	#so to prevent validation to return false the user's username and email is copied to required fields.
	def set_user
		if self.user
			self.username = self.user.username
			self.user_email = self.user.email
		end
	end
end
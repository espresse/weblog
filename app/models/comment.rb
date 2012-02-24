class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :username, :presence => true
	validates :content, :presence => true, :length => { minimum: 2 }

	valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email, presence: true, format: { with: valid_email_regex }

	before_validation :set_user

	private 
	def set_user
		if self.user
			self.username = self.user.username
			self.user_email = self.user.email
		end
	end
end
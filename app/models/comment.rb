class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :username, presence: true, if: "user_id.blank?"
	validates :content, presence: true, length: { minimum: 2 }

	valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :user_email, presence: true, format: { with: valid_email_regex }, if: "user_id.blank?"

end

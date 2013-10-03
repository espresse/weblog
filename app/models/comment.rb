class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :username, presence: true, if: "user_id.blank?"
	validates :content, presence: true, length: { minimum: 2 }

	validates :user_email, presence: true, format: { with: Const::VALID_EMAIL_REGEX }, if: "user_id.blank?"

end

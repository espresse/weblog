class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true, length: {minimum: 2}

	default_scope order("created_at DESC")


	def to_param
		"#{id}-#{title.downcase.gsub(/[(,?!\'":.)]/, '').gsub(' ', '-').gsub(/-$/, '')}"
	end

end

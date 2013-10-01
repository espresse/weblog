class Tag < ActiveRecord::Base
	has_many :taggables
	has_many :posts, through: :taggables

	validates_uniqueness_of :name, case_sensitive: false

	def to_param
		"#{name}"
	end
end

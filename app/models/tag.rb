class Tag < ActiveRecord::Base
	has_many :taggables
	has_many :posts, through: :taggables

	validates :name, presence: true, uniqueness: true

  before_save do
    self.name = self.name.downcase
  end

	def to_param
		"#{name.downcase.gsub(/[(,?!\'":.)]/, '').gsub(' ', '-').gsub(/-$/, '')}"
	end
end

class Post < ActiveRecord::Base

	belongs_to :user, counter_cache: true

	validates :title, presence: true
	validates :content, presence: true, length: {minimum: 2}
	has_many :taggables, dependent: :destroy
	has_many :tags, through: :taggables
	has_many :comments, dependent: :destroy

	delegate :username, to: :user, prefix: true

	scope :ordered, -> { order("created_at DESC") }


	#adding SEO-friendly title for posts. Internet robots will scan the title and index it.
	#more SEO actions have to be prepared though.
	def to_param
		"#{id}-#{title.downcase.gsub(/[(,?!\'":.)]/, '').gsub(' ', '-').gsub(/-$/, '')}"
	end

	#tag list to be displayed in post's form
	def tag_list
		self.tags.map { |tag| tag.name }.join(', ')
	end

	#tag list taken from form has to be put into taggable
	def tag_list=(my_tags)
		_new_tags = my_tags.split(',').map { |t| t.strip }.uniq
		_recent_tags = self.tags.map { |tag| tag.name }

		unless _recent_tags.blank?
			tags_to_remove = _recent_tags - _new_tags
			tags_to_remove.each do |tag|
				self.tags.where(name: tag).first.destroy
			end
		end

		unless _new_tags.blank?
			tags_to_add = _new_tags - _recent_tags
			xtags = tags_to_add.map do |tag|
				Tag.find_or_create_by(name: tag)
			end
			self.tags << xtags
		end
	end
end

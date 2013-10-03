class Post < ActiveRecord::Base
	attr_accessor :tag_list

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
		@tag_list ||= self.tags.map { |tag| tag.name }.join(', ')
	end

	#tag list taken from form has to be put into taggable
	def tag_list=(my_tags)
		_new_tags = my_tags.split(',').map { |t| t.strip }.uniq
		_recent_tags = self.tags.map { |tag| tag.name }

		(_recent_tags - _new_tags).each { |tag| self.tags.where(name: tag).first.destroy } unless _recent_tags.blank?
		self.tags << (_new_tags - _recent_tags).map { |tag| Tag.find_or_create_by(name: tag) } unless _new_tags.blank?
		@tag_list = nil
	end
end

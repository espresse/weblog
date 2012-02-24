class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username
  attr_accessor :password

  has_many :posts

  validates_confirmation_of :password
  validates :password, presence: true, length: { minimum: 6}, :on => :create

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: { case_sensitive: false }
  validates :username,  presence: true, length: { maximum: 25 }, uniqueness: { case_sensitive: false }

  default_scope :order => ('posts_count desc')
  
end
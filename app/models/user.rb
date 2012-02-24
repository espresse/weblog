class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username
  attr_accessor :password

  before_save :encrypt_password

  has_many :posts, :dependent => :destroy

  validates_confirmation_of :password
  validates :password, presence: true, length: { minimum: 6}, :on => :create

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: { case_sensitive: false }
  validates :username,  presence: true, length: { maximum: 25 }, uniqueness: { case_sensitive: false }

  default_scope :order => ('posts_count desc')
  
  scope :active_5, limit(5)

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
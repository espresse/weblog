class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password

  has_many :posts, dependent: :destroy

  validates_confirmation_of :password
  validates :password, presence: true, length: { minimum: 6}, on: :create

  validates :email, presence: true, format: { with: Const::VALID_EMAIL_REGEX }, uniqueness: true
  validates :username,  presence: true, length: { maximum: 25 }, uniqueness: true

  scope :ordered, -> { order('posts_count desc') }

  scope :active_5, -> { limit(5) }

  before_validation do
    self.email = self.email.downcase if self.email
  end

  #user authentication
  #when user fills in his/her password, it is being hashed (with user's password salt) and compared with password hash stored in db
  #if it is same then user is authenticated
  def self.authenticate(email, password)
    user = find_by(email: email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  #this is used for generating password salt and hash from user's password
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

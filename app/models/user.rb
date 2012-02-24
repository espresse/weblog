class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username
  attr_accessor :password

  has_many :posts
  
  validates_confirmation_of :password

end
class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :email, :password, presence: true
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug 
    username.gsub(" ", "-")
  end 
  
  def self.find_by_slug(slugged)
    User.find_by(username: slugged.gsub("-"," "))
  end   
end

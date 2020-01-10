class User < ActiveRecord::Base
  
  has_secure_password
  has_many :tweets
  
  def slug
    return self.username.gsub(' ', '-').downcase
  end
  
  def self.find_by_slug(string)
    return self.all.select do |instance|
      instance.slug == string
    end.first
  end
  
end


require_relative '../config/environment'
class Tweet < ActiveRecord::Base
  belongs_to :user
end

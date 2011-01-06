class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_tagger
  
  def self.andy
    User.find_by_login(:andy)
  end
end
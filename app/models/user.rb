class User < ActiveRecord::Base
  acts_as_authentic
  
  def self.andy
    User.find_by_login(:andy)
  end
end
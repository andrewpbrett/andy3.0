class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :excerpt, :permalink, :status  
end
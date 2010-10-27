class UpdatesController < ApplicationController
  def index
    @updates = Update.find(:all, :order => "published_at DESC" )
  end
end
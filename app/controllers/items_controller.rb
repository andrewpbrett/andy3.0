class ItemsController < ApplicationController
  def index
    Subscription.all.each do |s|
      s.poll
    end
    @items = Item.order("published_at DESC")
  end
end
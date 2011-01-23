module ApplicationHelper
  def linkify(string, external=true)
    if external
      string.gsub(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/([^\s])*)?/ix, '<a href="\0" target="_blank">\0</a>')
    else
      string.gsub(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/([^\s])*)?/ix, '<a href="\0">\0</a>')
    end
  end  
  
  def filter_bookmark_note(string)
    last = string[string.length - 1..string.length]
    string = string[0..string.length - 2] if last  == "."
    string += ":" unless last == ">"
    string
  end
  
  def display_in_timeline(object)
    if object.is_a? Post
      render :partial => "posts/show", :locals => 
        { :post => object, :show_excerpt => true }
    elsif object.is_a? Update
      render :partial => "updates/show", :locals => { :update => object }
    elsif object.is_a? Image
      render :partial => "images/show", :locals => { :image => object }
    elsif object.is_a? Bookmark
      render :partial => "bookmarks/show", :locals => { :b => object }
    end
  end
end
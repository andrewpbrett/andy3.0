module ApplicationHelper
  def linkify(string, external=true)
    if external
      string.gsub(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/([^\s])*)?/ix, '<a href="\0" target="_blank">\0</a>')
    else
      string.gsub(/(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/([^\s])*)?/ix, '<a href="\0">\0</a>')
    end
  end  
end

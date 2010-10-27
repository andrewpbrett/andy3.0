namespace :import do
  desc "import from blogger dump file"
  task :blogger => :environment do
    doc = open("/Users/andybrett/Desktop/archive/blog.xml") { |f| Hpricot(f) }
    entries = doc.search("//entry")
    entries.each do |entry|
      cat = entry/"category"
      draft = entry/"app:draft"
      if cat[0]['term'] == "http://schemas.google.com/blogger/2008/kind#post" and draft.inner_html == ""
        coder = HTMLEntities.new
        content = entry/"content"
        body = coder.decode(content.inner_html)
        t = entry/"title"
        title = t.inner_html
        time = entry/"published"
        published_at = time.inner_html
        permalink = title.downcase.gsub(/\s/, '-').gsub(/[^A-Z^a-z^0-9^-]/, '')
        Post.create(:permalink => permalink, :published_at => published_at, :title => title, :body => body, :status => "published")
      end
    end
  end
  
  desc "import updates from twitter xml dump"
  task :twitter => :environment do
    doc = open("/Users/andybrett/Dropbox/tweets.xml") { |f| Hpricot(f) }
    tweets = doc.search("//status")
    tweets.each do |update|
      dates = update/"created_at"
      date = dates[0].inner_html
      coder = HTMLEntities.new      
      text = update/"text"
      text = coder.decode(text.inner_html)
      Update.create(:published_at => date, :body => text)
    end
  end
end
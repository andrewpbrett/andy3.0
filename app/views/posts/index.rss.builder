xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Andy Brett: Writing"
    xml.description "Long form musings from Andy Brett"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link "http://andybrett.com/" + post.permalink
        xml.guid "http://andybrett.com/" + post.permalink
        xml.author "Andy Brett"
      end
    end
  end
end
class Subscription < ActiveRecord::Base
  has_many :items
  
  def poll
    self.send "poll_#{source}"
  end
  
  def poll_facebook
    conf = YAML.load_file("config/pwd.yml")
    key = conf["facebook"]
    http = Net::HTTP.new("graph.facebook.com", 443)
    http.use_ssl = true
    path = URI.parse(self.url).path + "?access_token=" + key
    response, data = http.get(path, nil)
    json = JSON.parse(data)
    json["data"].each do |item|
      i = Item.find_by_external_id(item["id"])
      if i.nil?
        i = Item.create(:external_id => item["id"], :url => item["link"],
            :title => item["name"], :text => item["description"],
            :published_at => DateTime.parse(item["created_time"]),
            :subscription => self)
      end
    end
  end
  
  def poll_twitter
    u = url 
    u += "&since_id=#{last_item.external_id}" if last_item
    data = Net::HTTP.get(URI.parse(URI.encode(u)))
    json = JSON.parse(data)
    json.each do |item|
      i = Item.find_by_external_id(item["id_str"])
      if i.nil?
        i = Item.create(:external_id => item["id_str"], 
          :url => "http://twitter.com/#{item["user"]["screen_name"]}/status/#{item["id_str"]}",
          :text => item["text"],
          :title => item["text"],          
          :published_at => DateTime.parse(item["created_at"]),
          :source_image_url => item["user"]["profile_image_url"],
          :subscription => self)
      end
    end
  end
  
  def poll_rss
    
  end
  
  def last_item
    i = Item.where(:subscription_id => self.id).order("published_at DESC").limit(1)
    i.present? ? i.first : nil
  end
  
  def source
    return "facebook" if url.match(/.*facebook.*/)
    return "twitter" if url.match(/.*twitter.*/)
    return "rss" if url.match(/.*rss$/)
    return "rss"
  end
end
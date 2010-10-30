class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    @page_title = "Andy Brett"
  end
  
  private
  
  def tweet(text)
    pwd = YAML.load_file("config/pwd.yml")
    consumer_key = pwd["twitter_consumer_key"]
    consumer_secret = pwd["twitter_consumer_secret"]
    access_token = pwd["twitter_access_token"]
    access_token_secret = pwd["twitter_access_token_secret"]
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, { :site => 'http://api.twitter.com', :scheme => :header })
    access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)    
    encoded_text = CGI.escape(text)    
    response = access_token.request(:post, "http://api.twitter.com/1/statuses/update.json?status=#{encoded_text}")
  end
  
  def prepare_access_token(oauth_token, oauth_token_secret)

    consumer = OAuth::Consumer.new(key, secret,
      { :site => "http://api.twitter.com",
        :scheme => :header
      })
    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token,
                   :oauth_token_secret => oauth_token_secret
                 }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    return access_token
  end  

  def authenticate
    pwd = YAML.load_file("config/pwd.yml")
    authenticate_or_request_with_http_basic do |user, pass|
      auth = (user == "andy" && pass == pwd["andy"])
      @authenticated = true
      auth
    end
  end  
end

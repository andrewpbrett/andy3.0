class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    @page_title = "Andy Brett"
  end
  
  private
  
  def tweet(text, geolat, geolong, place_id)
    pwd = YAML.load_file("config/pwd.yml")
    consumer_key = pwd["twitter_consumer_key"]
    consumer_secret = pwd["twitter_consumer_secret"]
    access_token = pwd["twitter_access_token"]
    access_token_secret = pwd["twitter_access_token_secret"]
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, { :site => 'http://api.twitter.com', :scheme => :header })
    access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)    
    encoded_text = CGI.escape(text)    
    response = access_token.request(:post, 
      "http://api.twitter.com/1/statuses/update.json?status=#{encoded_text}&place_id=#{place_id}&lat=#{geolat}&long=#{geolong}")
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

  def authorize
    redirect_to root_url unless current_user == User.andy
  end  
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to user_home
      return false
    end
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end  
end

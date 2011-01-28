class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :store_location
    
  def index
    @page_title = "Andy Brett"
  end

  def shorten_url
    return unless current_user == User.andy
    url = params[:url]
    http = Net::HTTP.new('www.googleapis.com', 443)
    http.use_ssl = true
    
    path = "/urlshortener/v1/url"
    data = "{\"longUrl\" : \"#{url}\", \"key\" : \"AIzaSyApp-49fvHtnEHcH_1dIdmC57PfvpObvMw\" }"
    headers = {"Content-Type"=>"application/json"}
    
    response, return_data = http.post(path, data, headers)
    respond_to do |format|
      format.json { render :json => return_data }
    end
  end
    
  private
  
  def store_location
    session[:return_to] = nil
    session[:return_to] = request.fullpath unless request.fullpath == "/"
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
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
    unless current_user == User.andy
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
    end      
  end  
  
  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
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

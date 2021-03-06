class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :store_location
  before_filter :find_or_initialize, :only => 
    [:show, :new, :create, :edit, :update]
    
  def index
    @page_title = "Andy Brett"
  end
  
  def tweetables
    render :layout => false
  end

  def shorten_url
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
  
  def get_twitter_places
    return unless current_user == User.andy
    lat = params[:lat]
    long = params[:long]
    granularity = params[:granularity].present? ? params[:granularity] : "poi"
    ret = JSON.parse(Net::HTTP.get_response(URI.parse("http://api.twitter.com/1/geo/search.json?lat=#{lat}&long=#{long}&granularity=#{granularity}&max_results=40")).body)

    respond_to do |format|
      format.json { render :json => ret }
    end
  end
    
  private
  
  def model_name
    params[:controller].singularize
  end
  
  def model_class
    model_name.camelize.constantize
  end
  
  def find_or_initialize
    i = model_class.find_by_id(params[:id]) if params[:id].present?
    i = model_class.find_by_permalink(params[:id]) if i.blank? and params[:id].present?
    i = model_class.find_by_permalink(params[:permalink]) if i.blank? and params[:permalink].present?
    instance_variable_set "@#{model_name}", params[:id].nil? ? model_class.new : i
    render :template => "application/notfound" and return if 
      (params[:permalink].present? or params[:id].present?) and i.blank?
  end
  
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

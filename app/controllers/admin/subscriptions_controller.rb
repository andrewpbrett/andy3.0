class Admin::SubscriptionsController < AdminController
  def index
    @subscriptions = Subscription.all
  end
  
  def new
    @subscription = Subscription.new
  end
  
  def create
    @subscription = Subscription.create(params[:subscription])
    if @subscription.save
      flash[:notice] = "Subscription saved"
      redirect_to :action => :index
    else
      flash[:notice] = "Whoops"
      redirect_to :action => :new
    end
  end
  
  def edit
    @subscription = Subscription.find(params[:id])
  end
  
  def update

  end
end
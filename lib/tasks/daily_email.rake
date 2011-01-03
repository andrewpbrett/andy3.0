namespace :daily_email do
  desc "process mail"
  task :process => :environment do
    conf = YAML.load_file("config/pwd.yml")
    email = conf["daily_email"]
    pwd = conf["daily_email_pwd"]
    f = Fetcher.create({:type => :imap, 
      :receiver => IncomingMailHandler, 
      :server => "IMAP.gmail.com", 
      :username => email, 
      :password => pwd, 
      :port => 993, 
      :ssl => "yes", 
      :use_login => "yes"})
    f.fetch
  end
  desc "send email"
  task :send => :environment do 
    DailyMailer.daily_email.deliver
  end
end
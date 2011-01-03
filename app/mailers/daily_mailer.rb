class DailyMailer < ActionMailer::Base
  conf = YAML.load_file("config/pwd.yml")
  email = conf["daily_email"]
  
  default :from => email
  smtp_settings[:user_name] = email

  def daily_email
    mail(:to => "andy@andybrett.com",
         :subject => "It's #{Date.today.strftime("%A, %b %d %Y")}. How was your day?")
  end
end
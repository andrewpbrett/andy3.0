class IncomingMailHandler < ActionMailer::Base 
  def receive(email) 
    date = email.subject[email.subject.index(',') + 1..email.subject.index('.') - 1]
    permadate = date.downcase.gsub!("\s", "") if date

    full_body = email.parts[1].body.decoded
    body = full_body[0, full_body.index("<div class=\"gmail_quote\"")]
    
    Post.create(:permalink => "my-life-#{permadate}", :body => body,
                :title => "Daily note for #{date}", :published_at => Time.now)
  end 
end
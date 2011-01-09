class IncomingMailHandler < ActionMailer::Base 
  def receive(email) 
    date = Date.parse(email.subject[email.subject.index(',') + 1..email.subject.index('.') - 1])

    full_body = email.parts[1].body.decoded
    body = full_body[0, full_body.index("<div class=\"gmail_quote\"")]
    
    p = Post.create(:permalink => "my-life-#{date.to_s}", :body => body,
                :title => "Daily note for #{date.to_s}", :published_at => Time.now)
    p.tag_list << "daily-email"
    p.save
  end 
end
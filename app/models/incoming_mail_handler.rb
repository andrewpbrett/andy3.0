class IncomingMailHandler < ActionMailer::Base 
  def receive(email) 
    date = Date.parse(email.subject[email.subject.index(',') + 1..email.subject.index('.') - 1])

    full_body = email.parts[1].body.decoded
    logger.error "parts[0] was #{email.parts[0]}"
    logger.error "parts[1] was #{email.parts[1]}"    
    logger.error "full body was #{full_body}"    
    body = full_body.index("EOM") ? full_body[0, full_body.index("EOM")] : full_body
    logger.error "body was #{body}"
    p = Post.create(:permalink => "my-life-#{date.to_s}", :body => body,
                :title => "Daily note for #{date.to_s}", :published_at => Time.now)
    p.tag_list << "daily-email"
    p.save
  end 
end
class IncomingMailHandler < ActionMailer::Base 
  def receive(email) 
    date = email.subject[email.subject.index(',') + 1..email.subject.index('.') - 1]
    permadate = date.downcase.gsub!("\s", "")
    # TODO parse email.body
    Post.create(:permalink => "my-life-#{permadate}", :body => email.body,
                :title => "Daily note for #{date}", :published_at => Time.now)
  end 
end
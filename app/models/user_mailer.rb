class UserMailer < ActionMailer::Base
  
  require 'net/imap'
  require 'tmail'

  def welcome_email(user)
    recipients    user.email
    from          "My Awesome Site Notifications <notifications@example.com>"
    subject       "Welcome to My Awesome Site"
    sent_on       Time.now
    body          :user => user, :url => "http://example.com/login"
  end

 def test_email()
    recipients    "chazzer@webzealot.com"
    from          "My Awesome Site Notifications <notifications@example.com>"
    subject       "Welcome to My Awesome Site"
    sent_on       Time.now
    body          :url => "http://example.com/login"
    content_type "text/html"
  end

 def not_found(user)
    recipients    user.email
    from          "BlogNog Email Bot <email_bot@blognogresearch.com>"
    subject       "Problem with your submission"
    sent_on       Time.now
    body          :login => user.login
    content_type "text/html"
  end

  def receive(email)
    page = Page.find_by_address(email.to.first)
    page.emails.create(
      :subject => email.subject,
      :body => email.body
    )

    if email.has_attachments?
      for attachment in email.attachments
        page.attachments.create({
          :file => attachment,
          :description => email.subject
        })
      end
    end
  end

  def self.check_mail

    imap = Net::IMAP.new('secure.emailsrvr.com')
imap.login('study@blognogresearch.com', 'masterkey')
imap.select('INBOX')
imap.search(["NOT", "DELETED"]).each do |message_id|
  msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
  #UserMailer.receive(msg)
  #@body = msg.body
  #@subject = msg.subject
  #@from = msg.from
  imap.store(message_id, "+FLAGS", [:Deleted])
end
imap.expunge()
#imap.logout()
#imap.disconnect()
  end

end

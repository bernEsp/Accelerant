class UserMailer < ActionMailer::Base

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

end

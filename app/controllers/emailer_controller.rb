class EmailerController < ApplicationController

  layout 'plain'

  
  def index
    UserMailer.check_mail
    #UserMailer.deliver_test_email()
  end

end

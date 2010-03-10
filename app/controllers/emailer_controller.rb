class EmailerController < ApplicationController

  layout 'plain'

  
  def index
    UserMailer.deliver_test_email()
  end

end

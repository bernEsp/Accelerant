# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  after_filter OutputCompressionFilter

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '192577a9bd2451d4f3032dbb7733e8d9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  include AuthenticatedSystem
  include SslRequirement
  
  uses_yui_editor

  #http://www.ruby-forum.com/topic/204710#new

 #rescue_from ActionController::InvalidAuthenticityToken, :with => :handle_token_issues

def handle_token_issues
  #redirect to page for handling this issue
  #redirect_to('cookies') 
end

end

class StartController < ApplicationController
  layout 'start'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index
  end

end

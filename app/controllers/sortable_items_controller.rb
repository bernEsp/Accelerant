class Sortableitems < ActiveRecord::Base

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :show, :destroy
  end

end
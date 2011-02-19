class ClientController < ApplicationController
  before_filter :login_required

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end

  def index
    client_id = self.current_user.id
    @projects = Project.find(:all, :conditions => "client_id = #{self.current_user.id}")

    
  end
end

class ClientController < ApplicationController
  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end
  
  def index
    client_id = self.current_user.id
    @projects = Project.find(:all, :conditions => "client_id = #{self.current_user.id}")

    @last_ass = Project.find(:last, :conditions => "client_id = #{self.current_user.id}")
    @ass = Project.find(@last_ass.id)
    @theme = Themes.find(@ass.theme)

    unless @theme.nil?
      session[:theme] = @theme.id
    else
      session[:theme] = nil
    end
  end
end

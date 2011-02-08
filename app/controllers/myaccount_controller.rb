class MyaccountController < ApplicationController
  before_filter :login_required
  
  if ENV['RAILS_ENV'] == 'production'
    ssl_allowed :index, :edit, :update
  end

  def index
    @user = User.find(:last, :conditions => { :id => self.current_user.id})
  end
  
  def edit
    @user = User.find(:last, :conditions => { :id => self.current_user.id})
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.errors.empty?
      flash[:notice] = "Updated!"
    else
      flash[:notice] = "Update Failed"
    end
    if self.current_user.moderator
      redirect_to "/moderator"
    end
     redirect_to "/myaccount/edit"
  end
  
end

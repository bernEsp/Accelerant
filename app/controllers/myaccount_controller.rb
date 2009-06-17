class MyaccountController < ApplicationController
  before_filter :login_required
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
     redirect_to users_path
  end
  
end

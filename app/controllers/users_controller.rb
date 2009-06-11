class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  def index
    @users = User.find(:all)
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.errors.empty?
      flash[:notice] = "Updated!"
    else
      flash[:notice] = "Update Failed"
    end
     #redirect_to users_path
     redirect_to '/users'
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to  users_path
  end
  def dump_this
    @user = User.find(params[:id])
    @user.destroy
    render :text => "User Deleted"
  end
  
  def new
    @user = User.new
  end
 
  def create
    if !logged_in?
      logout_keeping_session!
    end  
    @user = User.new(params[:user])
    success = @user && @user.save
    if @user.participant?
      @participant = Participant.new
      @participant.update_attribute :id, @user.id
      @participant.save
    end
    if @user.admin?
      @admin = Admin.new
      @admin.update_attribute :id, @user.id
      @admin.save
    end
    if @user.client?
      @client = Client.new
      @client.update_attribute :id, @user.id
      @client.save
    end
    if @user.moderator?
      @moderator = Moderator.new
      @moderator.update_attribute :id, @user.id
      @moderator.save
    end
    if success && @user.errors.empty?
      if logged_in?
      if !self.current_user.admin
        flash[:notice] = "New user successfully created."
         redirect_to '/users'
      else
        flash[:notice] = "New user successfully created."
        redirect_to '/users'
      end
      else
        flash[:notice] = "New user successfully created."
        redirect_to '/users'
      end
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end

  def activate
    if !self.current_user.admin
      logout_keeping_session!
    end
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      if !self.current_user.admin
        redirect_to '/login'
      else
        redirect_to '/users'
      end
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  # render new.rhtml
  
  def rock_n_roll
  end
  
 
end

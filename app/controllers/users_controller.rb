class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  #before_filter :login_required, :only => [:detail]
  before_filter :admin_required, :only => [ :index ]
  before_filter :not_participant, :only => [:detail, :edit, :destroy, :new, :create, :your_users, :add]
  #before_filter :client_required, :only => [ :detail ]
  #before_filter :moderator_required, :only => [ :detail ]

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :update, :edit, :new, :create, :destroy, :dump_this, 
      :activate, :detail, :showsessions, :your_users, :add
  end

  def index
    @users = User.find(:all)
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end

  def your_users
    @projects = Project.find(:all, :conditions => {:moderator_id => self.current_user.id })
    
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if params[:user_type] == "admin"
      @user.admin = true
      @user.moderator = false
      @user.client = false
      @user.participant = false
    end
    if params[:user_type] == "moderator"
      @user.admin = false
      @user.moderator = true
      @user.client = false
      @user.participant = false
    end
    if params[:user_type] == "client"
      @user.admin = false
      @user.moderator = false
      @user.client = true
      @user.participant = false
    end
    if params[:user_type] == "participant"
      @user.admin = false
      @user.moderator = false
      @user.client = false
      @user.participant = true
    end
    @user.save
    if @user.errors.empty?
      flash[:notice] = "Updated!"
    else
      flash[:notice] = "Update Failed"
    end
     #redirect_to users_path
    if self.current_user.participant || self.current_user.client
       redirect_to '/myaccount/edit'
    end
    if self.current_user.moderator
       redirect_to '/your_users'
    end
    if self.current_user.admin
      redirect_to users_path
    end
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
    self.current_user = @user
  end

  def add
    @user = User.new
  end
 
  def create
    if !logged_in?
      logout_keeping_session!
    end  
    @user = User.new(params[:user])
    if params[:user_type] == "admin"
      @user.admin = true
      @user.moderator = false
      @user.client = false
      @user.participant = false
    end
    if params[:user_type] == "moderator"
      @user.admin = false
      @user.moderator = true
      @user.client = false
      @user.participant = false
    end
    if params[:user_type] == "client"
      @user.admin = false
      @user.moderator = false
      @user.client = true
      @user.participant = false
    end
    if params[:user_type] == "participant"
      @user.admin = false
      @user.moderator = false
      @user.client = false
      @user.participant = true
    end
    success = @user && @user.save
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
        self.current_user = @user
        flash[:notice] = "New user successfully created."
        redirect_to '/users'
      end
    else
      self.current_user = @user
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end

 def add_new
    if !logged_in?
      logout_keeping_session!
    end
    @user = User.new(params[:user])
    if params[:user_type] == "participant"
      @user.admin = false
      @user.moderator = false
      @user.client = false
      @user.participant = true
    end
    success = @user && @user.save
    if success && @user.errors.empty?
      @userassignments = UserAssignments.new
      @userassignments.user_id = @user.id
      @userassignments.project_id = params[:dump][:project_id]
      @userassignments.save
      if logged_in?
        if self.current_user.moderator?
         flash[:notice] = "New user successfully created."
         redirect_to '/your_users'
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
  
  def detail
    @usersortablestest = Usersortables.find_all_by_user(params[:id])
    @this_user = User.find(:last, :conditions => {:id => params[:id] })
    @assignments = UserAssignments.find(:all, :conditions => {:user_id => params[:id]})
    @these_comments = Comment.belongs_to_discussion.find(:all, :conditions => { :user_id => params[:id]})
    @these_replies = Replies.find(:all, :conditions => {:user_id => params[:id]})

    unless @assignments.last.nil?
      @category = AttributeTags.find_last_by_project_id(@assignments.last.project_id)
    end

  end

  def showsessions
    @sessions = Sessions.find(:all)
  end

 
end

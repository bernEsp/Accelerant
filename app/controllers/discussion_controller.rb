class DiscussionController < ApplicationController
  before_filter :login_required
#  if ENV['RAILS_ENV'] == 'production'
#    ssl_required :index, :show, :new, :create, :edit, :update, :delete
#  end

  def new
    @discussion = Discussion.new
    @comment_assignment = CommentAssignments.new
  end

  def delete
    @discussion = Discussion.find(params[:id])
    project = @discussion.project_id
    @discussion.destroy
    redirect_to :controller => 'assignment', :action => 'show', :id => project
  end

  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.save
    #new stuff
      if self.current_user.admin? || self.current_user.moderator?
      @user_assignments = params[:comment_assignment]
      if @user_assignments
        @these_keys = @user_assignments.keys
        @user_assignments.each do |key, value|
          #if value=="0"
            if value !="0"
            @comment_assignment = CommentAssignments.new
            @comment_assignment.update_attributes(:user_id => key, :discussion_id => @discussion.id)
            @comment_assignment.save
          end
      end
      end
    end
    redirect_to "/assignment/#{@discussion.project_id}"
  end

  def show
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => params[:project_id]}, :include => :user)
    #@project = Project.find(:all, :conditions => {:id => params[:project_id]})
    @project = Project.find(params[:project_id])
    @discussions = Discussion.find(:all, :conditions => {:project_id => params[:project_id]})
    unless params[:sort] == "by_user"
      @discussion = Discussion.find(params[:id])
    else
      if @discussions && session[:discussion_id].nil?
        @discussion = Discussion.find(params[:id])
      else
         @discussion = Discussion.find(session[:discussion_id])
      end
    end
    unless !@discussion || @discussion.sortable.nil?
    @sortable = Sortables.find(@discussion.sortable)
    unless @sortable.nil?
      @usersortables = Usersortables.find_all_by_sortable(@sortable.id, :conditions => {:user => self.current_user.id}, :order => "position ASC" )
      if @usersortables.empty?
        @sortableitems = Sortableitems.find_all_by_sortables(@sortable.id)
        for sortableitem in @sortableitems
          @newusersortable = Usersortables.new
          @newusersortable.user = self.current_user.id
          @newusersortable.sortableitem = sortableitem.id
          @newusersortable.sortable = sortableitem.sortables
          if self.current_user.participant
            @newusersortable.participant = true
          else
            @newusersortable.participant = false
          end
          @newusersortable.save
          @usersortables = Usersortables.find_all_by_sortable(@sortable.id, :conditions => {:user => self.current_user.id}, :order => "position ASC" )
        end
        puts "didnt find none"
      else
        for usersorts in @usersortables
          if self.current_user.participant
            puts "woopee"
            usersorts.participant = true
            usersorts.save
          end
          puts "found some"
        end
      end
    end
    end

    unless !@discussion || @discussion.groupable.nil?
    puts "and we are IN"
    @groupable = Groupables.find(@discussion.groupable)
    @groupabletargets = Groupabletargets.find_all_by_groupable(@groupable.id, :order => "id DESC")
    unless @groupable.nil?
      @usergroupables = Usergroupables.find_all_by_groupable(@groupable.id, :conditions => {:user => self.current_user.id} )
      if @usergroupables.empty?
        @groupableitems = Groupableitems.find_all_by_groupables(@groupable.id)
        for groupableitem in @groupableitems
          @newusergroupable = Usergroupables.new
          @newusergroupable.user = self.current_user.id
          @newusergroupable.groupableitem = groupableitem.id
          @newusergroupable.groupable = groupableitem.groupables
          if self.current_user.participant
            @newusergroupable.participant = true
          else
            @newusergroupable.participant = false
          end
          @newusergroupable.save
          @usergroupables = Usergroupables.find_all_by_groupable(@groupable.id, :conditions => {:user => self.current_user.id})
        end
        puts "did not find groupable"
      else
        for usergroups in @usergroupables
          if self.current_user.participant
            puts "woopee"
            usergroups.participant = true
            usergroups.save
          end
          puts "found some"
        end
      end
    end
    end
    if @discussion.has_heatmap
      heatmap = Heatmap.find(:last, :conditions => {:discussion_id => @discussion.id , :user_id => self.current_user.id})
      if heatmap && heatmap.comment_id.nil?
        heatmap.comment_id = session[:comment_id]
        heatmap.save
      end
      
    end
    session[:discussion_id] = params[:id].blank? ? @discussion.id : params[:id]
    discussion = {:user_name => self.current_user.name, :user_id => self.current_user.id, :admin => self.current_user.admin, :image_path => @discussion.media.url, :discussion_id => @discussion.id}
    respond_to do |format|
     format.html
     format.xml { render :xml => discussion.to_xml(:dasherize => false), :layout => false}
    end

  end

  def edit
    
    @discussion = Discussion.find(params[:id])
    @project_members = UserAssignments.find(:all, :conditions => {:project_id => @discussion.project_id}, :include => :user)
  end

  def update
     @discussion = Discussion.find(params[:id])
     @discussion.update_attributes(params[:discussion])
         #new stuff
      if self.current_user.admin? || self.current_user.moderator?
      @user_assignments = params[:comment_assignment]
      if @user_assignments
        @these_keys = @user_assignments.keys
        @user_assignments.each do |key, value|
          #if value=="0"
            if value !="0"
            @comment_assignment = CommentAssignments.new
            @comment_assignment.update_attributes(:user_id => key, :discussion_id => @discussion.id)
            @comment_assignment.save
          end
      end
      end
    end
    redirect_to :controller => 'assignment', :action => 'show', :id => @discussion.project_id
  end

  def discussion_show
    discussion =  Discussion.find(session[:discussion_id])
    xml_data =  Discussion.create_xml(self.current_user, discussion)
    respond_to do |format|
     format.xml { render :xml => xml_data.to_xml(:dasherize => false)}
    end
  end
end

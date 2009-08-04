class DiscussionController < ApplicationController
  def new
    @discussion = Discussion.new
    @comment_assignment = CommentAssignments.new
  end

  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.save
    #new stuff
      if self.current_user.admin? || self.current_user.moderator?
      @user_assignments = params[:comment_assignment]
      @these_keys = @user_assignments.keys
      @user_assignments.each do |key, value|
        if value=="0"
          @comment_assignment = CommentAssignments.new
          @comment_assignment.update_attributes(:user_id => key, :discussion_id => @discussion.id)
          @comment_assignment.save
        end
      end
    end
    redirect_to "/assignment/#{@discussion.project_id}"
  end

end
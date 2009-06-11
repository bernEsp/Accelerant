class CommentsController < ApplicationController
  def index
    user_id = self.current_user.id
    @comments = Comment.find(:all,:conditions => { :user_id => user_id})
  end
  
  def show
    user_id = self.current_user.id
    @comments = Comment.find(:all, :conditions => { :user_id => user_id})
  end

  def new
    @comment = Comment.find(:all)
    @comment = Comment.new
  end
  
  def get
    @comment = Coment.new
  end

  def create
    @comment = Comment.new(params[:comments])
    #@object_comment = Object.new(params[:object])
    #@comment.update_attribute :comment, params[:object][:comment]
    #comment.title = params[:title][:thefieldiwanttouse].to_s
    #@attachable_file = AttachmentMetadataModel.new(params[:comments])
    @comment.save
    #if @comment.save
      #render :text => @comment.comment
      #redirect_to "/assignment/#{@comment.assignment_id}"
    #else
      #render(:action => :get)
    #end
    #render :text => @comment.comment
    redirect_to "/assignment/#{@comment.assignment_id}"
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
  
end

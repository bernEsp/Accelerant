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
    @comment.save
    #if @comment.save
     # render :text => @comment.comment
    #else
     # render(:action => :get)
    #end
    render :text => @comment.comment
    #redirect_to "/assignment/#{@comment.assignment_id}"
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #render :text => "Removed"
  end
  
  def picture
    @picture = Comment.find(params[:id])
    send_data(@picture.data,
              :filename => @picture.name,
              :type => @picture.content_type,
              :disposition => "inline")
  end
end

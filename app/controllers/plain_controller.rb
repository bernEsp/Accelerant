class PlainController < ApplicationController
  layout 'plain'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :showlatest, :update_count, :sub_comment_form, 
      :sub_form, :show_comments, :drop_comment, :drop_reply, :follow_up
  end
  
  def index
     @latest_postings = Comment.find(:all, :conditions => {:assignment_id => params[:id] }, :limit => 5, :order => "id DESC")
  end
  
  def showlatest
    #this one is the refresher
     @latest_postings = Comment.find(:all, :conditions => {:assignment_id => params[:id] }, :order => "id DESC")
  end
  
  def update_count
    comment_count = Comment.count(:conditions => {:assignment_id => params[:id]} )
  end
  
  def sub_comment_form
    render :partial => "sub_form"
  end

  def sub_form
    render :partial => "sub_form"
  end
  
  def show_comments
    @replies = Replies.find(:all, :conditions => { :comment_id => params[:id]}, :order => "id DESC")
  end
  
  def drop_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :text => "Deleted"
  end
  
  def drop_reply
    @reply = Replies.find(params[:id])
    @reply.destroy
    render :text => "Deleted"
  end

  def follow_up
    render :partial => "follow_up_form"
  end
  
end
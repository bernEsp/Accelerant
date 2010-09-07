class RepliesController < ApplicationController
  before_filter :login_required
  
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :show, :get, :update, :new, :create
  end

  def index
    user_id = self.current_user.id
    @replies = Reply.find(:all,:conditions => { :user_id => user_id})
  end
  
  def new
    @reply = Replies.find(:all)
    @reply = Replies.new
  end
  
  def get
    @reply = Replies.new
  end

  def create
    @discussion = Discussion.find(params[:reply][:discussion_id])
    #puts params[:reply][:content].length
    #puts (@discussion.character_minimum != 0)
    #puts (params[:reply][:content].length >= @discussion.character_minimum)
    if (@discussion.character_minimum == 0) || ((@discussion.character_minimum != 0 && params[:reply][:content].length >= @discussion.character_minimum))
      @reply = Replies.new(params[:reply])
      @reply.save
      #@comment = Comment.find(@reply.comment_id)
      #@discussion = Discussion.find(params[:reply][:discussion_id])
      #@assignment = Comment.find(:last, :conditions => {:id => params[:reply][:comment_id]})
      #redirect_to "/discussion/show/#{@discussion.id}?project_id=#{@discussion.project_id}#bottom"
      responds_to_parent do
        render :update do |page|
          #page << "document.getElementById('stuff').innerHTML = '';"
          #gunk = render_reply_standalone(@reply)
          #gunk = @reply.content
          #page << "document.getElementById('subCommentForm#{params[:reply][:comment_id]}').innerHTML = '#{@reply.content}';"
          page << "document.getElementById('subCommentForm#{params[:reply][:comment_id]}').innerHTML = 'Comment posted... Thank you!';"

          #page << "document.getElementById('subCommentForm#{@reply.comment_id}').innerHTML = '#{gunk}"
        end
      end
      
    else
      #render :text => "Response is too short.  Must be #{@discussion.character_minimum} characters minimum."
      responds_to_parent do
        render :update do |page|
          page << "document.getElementById('subCommentForm#{params[:reply][:comment_id]}').innerHTML = 'Response is too short.  Must be #{@discussion.character_minimum} characters minimum.';"
        end
      end
    end
  end

  def by_user
    @these_replies = Replies.find(:all, :conditions => { :user_id => params[:id]})
  end

end

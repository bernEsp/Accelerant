class MypostsController < ApplicationController
  
  def show
    @mycomments = Comment.find(:all, :conditions => ["user_id = #{self.current_user.id} and comment <> ''"], :order => "id DESC")
  end
end

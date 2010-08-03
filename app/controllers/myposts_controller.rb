class MypostsController < ApplicationController
  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :drop, :assign, :show
  end

  def show
    @mycomments = Comment.find(:all, :conditions => ["user_id = #{self.current_user.id} and comment <> ''"], :order => "id DESC")
  end
end

class FollowUpsController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :create, :show
  end

  def create
      @follow_up = FollowUps.new(params[:follow_up])
      @follow_up.read = false
      @follow_up.save
      render :text => "Follow up posted!"
  end

  def show
    @follow_ups = FollowUps.find(:all, :conditions => {:reply_belongs_to => self.current_user.id})
  end
end

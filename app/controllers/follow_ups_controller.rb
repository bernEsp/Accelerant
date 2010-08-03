class FollowUpsController < ApplicationController
  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :create, :show
  end

  def create
      @follow_up = FollowUps.new(params[:follow_up])
      unless self.current_user.participant
        @follow_up.read = false
      else
        @follow_up.read = true
      end
      @follow_up.save
      render :text => "Follow up posted!"
  end

  def show
    @follow_ups = FollowUps.find(:all, :conditions => {:reply_belongs_to => self.current_user.id}, :order => "id DESC")
  end
end

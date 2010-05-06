class FollowUpsController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :create
  end

  def create
      @follow_up = FollowUps.new(params[:follow_up])
      @follow_up.save
      render :text => "Follow up posted!"
  end
end

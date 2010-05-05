class FollowUpsController < ApplicationController
  def create
      @follow_up = FollowUps.new(params[:follow_up])
      @follow_up.save
      render :text => "Follow up posted!"
  end
end

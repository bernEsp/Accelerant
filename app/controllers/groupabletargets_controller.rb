class GroupabletargetsController < ApplicationController

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :new, :create
  end


  def create
    @groupabletargets = Groupabletargets.new(params[:groupabletargets])
    @groupabletargets.save
    redirect_to "/groupableitems/new/#{@groupabletargets.groupable}"
  end


end
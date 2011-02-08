class GroupabletargetsController < ApplicationController

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :new, :create, :createaxis
  end


  def create
    @groupabletargets = Groupabletargets.new(params[:groupabletargets])
    @groupabletargets.save
    redirect_to "/groupableitems/new/#{@groupabletargets.groupable}"
  end

  def createaxis
    @targetx = Groupableaxis.new
    @targetx.description = params[:xAxis]
    @targetx.groupable = params[:groupable]
    @targetx.orientation = "X"
    @targetx.save
    @xlow = Groupabletargets.new
    @xlow.description = "Both Low"
    @xlow.groupableaxis_id = @targetx.id
    @xlow.groupable = params[:groupable]
    @xlow.orientation = "both low"
    @xlow.save
    @xhigh = Groupabletargets.new
    @xhigh.description = "High #{@targetx.description}"
    @xhigh.groupableaxis_id = @targetx.id
    @xhigh.groupable = params[:groupable]
    @xhigh.orientation = "x high"
    @xhigh.save

    @targety = Groupableaxis.new
    @targety.description = params[:yAxis]
    @targety.groupable = params[:groupable]
    @targety.orientation = "Y"
    @targety.save
    @ylow = Groupabletargets.new
    @ylow.description = "High #{@targety.description}"
    @ylow.groupableaxis_id = @targety.id
    @ylow.groupable = params[:groupable]
    @ylow.orientation = "y high"
    @ylow.save
    @yhigh = Groupabletargets.new
    @yhigh.description = "Both High"
    @yhigh.groupableaxis_id = @targety.id
    @yhigh.groupable = params[:groupable]
    @yhighorientation = "both high"
    @yhigh.save
    redirect_to "/groupableitems/new/#{params[:groupable]}"
  end

end
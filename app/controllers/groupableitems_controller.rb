class GroupableitemsController < ApplicationController

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :new, :create, :group
  end

  def new
    @previousitems = Groupableitems.find_all_by_groupables(params[:id])
    @groupableitems = Groupableitems.new

    @previoustargets = Groupabletargets.find_all_by_groupable(params[:id])
    @groupabletargets = Groupabletargets.new
  end

  def create
    @groupableitems = Groupableitems.new(params[:groupableitems])
    @groupableitems.save
    redirect_to "/groupableitems/new/#{@groupableitems.groupables}"
  end

  def group
      groupableitem = params[:id].gsub('groupableitems_','')
      puts groupableitem
      puts params[:target]
      puts params[:user]
      usergroupable = Usergroupables.find_by_user_and_groupableitem(params[:user],groupableitem)
      usergroupable.position = params[:target]
      usergroupable.save
    render :nothing => true
  end

end
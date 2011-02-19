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
      groupableitem = params[:id].gsub('usergroupables_','')
      groupableitem = groupableitem.gsub('groupableitems_','')
      puts "groupable_item:"
      puts groupableitem
      puts params[:target]
      puts "user:"
      puts params[:user]
      usergroupable = Usergroupables.find_by_id(groupableitem)
      if usergroupable.nil?
        usergroupable = Usergroupables.new
        usergroupable.user = params[:user]
        usergroupable.groupableitem = groupableitem
        usergroupable.groupable = Groupableitems.find(params[:target]).groupables
      end
      usergroupable.position = params[:target]
      usergroupable.save
    render :nothing => true
  end

<<<<<<< HEAD
end
=======
end
>>>>>>> 01338ef24515822ab28e24158bdbcad5d4dc024f

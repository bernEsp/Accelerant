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
    #params[:groupables].each_with_index do |id, index|
      puts params[:id].gsub('groupableitems_','')
      puts params[:target]
      #Groupableitems.update_all(['position=?', index+1], ['id=?', id])
      # Update all Sortableitems to position=index+1 where id = id
    #end
    render :nothing => true
  end

end
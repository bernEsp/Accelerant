class GroupableitemsController < ApplicationController

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :new, :create, :sort
  end

  def new
    @previousitems = Groupableitems.find_all_by_groupables(params[:id])
    @groupableitems = Groupableitems.new
  end

  def create
    @groupableitems = Groupableitems.new(params[:groupableitems])
    @groupableitems.save
    redirect_to "/groupableitems/new/#{@groupableitems.groupables}"
  end

  def group
    params[:groupables].each_with_index do |id, index|
      Groupableitems.update_all(['position=?', index+1], ['id=?', id])
      # Update all Sortableitems to position=index+1 where id = id
    end
    render :nothing => true
  end

end
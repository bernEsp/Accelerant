class SortableitemsController < ApplicationController

  #before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    #ssl_required :index, :new, :create, :edit, :update, :show, :destroy
  end

  def new
    @previousitems = Sortableitems.find_all_by_sortables(params[:id])
    @sortableitems = Sortableitems.new
  end

  def create
    @sortableitems = Sortableitems.new(params[:sortableitems])
    @sortableitems.save
    redirect_to "/sortableitems/new/#{@sortableitems.sortables}"
  end

  def sort
    params[:sortables].each_with_index do |id, index|
      Sortableitems.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

end
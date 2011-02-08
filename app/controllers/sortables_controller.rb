class SortablesController < ApplicationController

  before_filter :login_required
#  if ENV['RAILS_ENV'] == 'production'
#    ssl_required :index, :new, :create, :edit, :update, :show, :destroy
#  end

  def index
    @sortables = Sortables.find(:all)
  end

  def new
    @sortables = Sortables.new
  end

  def create
    @sortables = Sortables.new(params[:sortables])
    @sortables.save
    redirect_to "/sortableitems/new/#{@sortables.id}"
  end

  def edit
    @sortable = Sortables.find_by_id(params[:id])
  end

  def update
    @sortable = Sortables.find_by_id(params[:sortables][:id])
    @sortable.update_attributes(params[:sortables])
    @sortable.save
    redirect_to "/sortableitems/new/#{@sortables.id}"
  end

  def show
    @sortable = Sortables.find_by_id(params[:id])
    @sortableitems = Sortableitems.find_all_by_sortables(params[:id], :order => "position")
  end

end

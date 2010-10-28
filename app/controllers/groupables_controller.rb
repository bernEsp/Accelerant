class GroupablesController < ApplicationController

    before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :show, :destroy
  end

  def index
    @groupables = Groupables.find(:all)
  end

  def new
    @groupables = Groupables.new
  end

  def create
    @groupables = Groupables.new(params[:groupables])
    @groupables.save
    redirect_to "/groupableitems/new/#{@groupables.id}"
  end

 def edit
    @groupable = Groupables.find_by_id(params[:id])
  end

  def update
    @groupable = Groupables.find_by_id(params[:groupables][:id])
    @groupable.update_attributes(params[:groupables])
    @groupable.save
    redirect_to "/groupableitems/new/#{@groupable.id}"
  end

  def show
    @groupable = Groupables.find_by_id(params[:id])
    @groupableitems = Groupableitems.find_all_by_groupables(params[:id], :order => "position")
  end

end
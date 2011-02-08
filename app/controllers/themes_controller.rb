class ThemesController < ApplicationController
  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :show
  end

  def index
    @themes = Themes.find(:all)
  end

  def new
    @theme = Themes.new
  end

  def create
    @theme = Themes.new(params[:theme])
    success = @theme && @theme.save
    if success
      redirect_to '/themes'
    else
      flash[:error]  = @theme.errors
      render :action => 'new'
    end
  end

  def edit
    @theme = Themes.find(params[:id])
    respond_to do |format|
      format.html
      format.css
    end
  end

  def update
     @theme = Themes.find(params[:id])
     @theme.update_attributes(params[:themes])
     success = @theme && @theme.save
     if success
      redirect_to '/themes'
     else
      flash[:error]  = @theme.errors
      render :action => 'edit'
    end
  end

  def show
    
  end

end

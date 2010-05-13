class ThemesController < ApplicationController

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
    @theme.save
    redirect_to '/themes'
  end

  def edit
    @theme = Themes.find(params[:id])
  end

  def update
     @theme = Themes.find(params[:id])
     @theme.update_attributes(params[:themes])
     @theme.save
    redirect_to "/themes"
  end

  def show
    
  end

end

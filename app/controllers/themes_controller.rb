class ThemesController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update
  end

  def index

  end

  def new

  end

  def create

  end

  def edit

  end

  def update
    
  end

end

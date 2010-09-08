class SortablesController < ApplicationController

  before_filter :login_required
  if ENV['RAILS_ENV'] == 'production'
    ssl_required :index, :new, :create, :edit, :update, :show, :destroy
  end

  def index
    @sortables = Sortables.find(:all)
  end

end
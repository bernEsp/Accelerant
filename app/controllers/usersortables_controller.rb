  class UsersortablesController < ApplicationController

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :sort
  end

  def sort
    params[:usersortables].each_with_index do |id, index|
      Usersortables.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  end
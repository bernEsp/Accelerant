  class UsersortablesController < ApplicationController


  def sort
    params[:usersortables].each_with_index do |id, index|
      Usersortables.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  end
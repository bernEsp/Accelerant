  class UsersortablesController < ApplicationController

  require 'csv'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :sort, :csv
  end

  def sort
    params[:usersortables].each_with_index do |id, index|
        Usersortables.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end

  def csv
    @NumItems = Sortableitems.count(:all, :conditions => {:sortables => params[:id]})
    @Items = Sortableitems.find(:all, :conditions => {:sortables => params[:id]})
    row = Array.new
    row << "Item"
    1.upto(@NumItems) { |n|
      row << "Rank Position #{n}"
    }
    allrows = Array.new
    allrows << row.to_csv
    for obj in @Items do
      row = Array.new
      row << obj.description
      1.upto(@NumItems) { |n|
        row << Usersortables.by_participant.count(:sortableitem, :conditions => {:sortableitem=> obj.id,:position => n})
      }

      allrows << row.to_csv
    end

    render :text => allrows
    response.headers['Content-Type'] = 'text/csv; charset=iso-8859-1;
header=present'
    response.headers['Content-Disposition'] = "attachment;
filename=sortable_frequencies.csv"
    end

  end
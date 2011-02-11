class HeatmapController < ApplicationController

  def create

      coords = params[:encodeData].to_a
      heatmap = Heatmap.new(:image_result => params[:image_data], :discussion_id => 10, :user_id => 6, :coord_x => coords[0], :coord_y => coords[1], :coord_radio => coords[2] )
      if heatmap.save
        respond_to do |format|
          format.html { render :nothing => true }
          format.xml { render :xml => 'success'}
        end
      else
        respond_to do |format| 
          format.html { render :nothing => true }
          format.xml { render :xml => 'error' }
        end
      end
  end

end

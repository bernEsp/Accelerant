class HeatmapController < ApplicationController

  def create
      coords = params[:encodeData].to_a
      discussion= Discussion.find(params[:discussion_id])
      heatmap = Heatmap.new(:image_result => params[:image_data], :user_id => 6)
      if heatmap.save
        discussion.heatmaps << heatmap
        heatmap_coords =HeatmapCoords.new(:coord_x => coords[0], :coord_y => coords[1], :coord_radio => coords[2])
        heatmap.heatmap_coords << heatmap_coords if heatmap_coords.save
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

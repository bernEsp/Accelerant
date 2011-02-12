class HeatmapController < ApplicationController

  def create
    if Heatmap.create_heatmap(params[:image_data], params[:encodeData], params[:user_id], params[:discussion_id])
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

  def show
    heatmap = Heatmap.find(params[:heatmap_id])
    heatmap.heatmap_coords
    respond_to do |format|
      format.xml {render :xml => heatmap.heatmap_coords}
    end
  end

end

class HeatmapController < ApplicationController

  def create
      last_comment = Comment.find(:last, :conditions => { :user_id => params[:user_id], :discussion_id => params[:discussion_id]})
      coords = params[:encodeData].to_a
      discussion= Discussion.find(params[:discussion_id])
      heatmap = Heatmap.new(:image_result => params[:image_data], :user_id => params[:user_id], :comment_id => last_comment.id)
      if heatmap.save
        discussion.heatmaps << heatmap
        coords.each do |coord|
          heatmap_coords =HeatmapCoord.new(:coord_x => coord[0], :coord_y => coord[1], :coord_radio => coord[2])
          heatmap.heatmap_coords << heatmap_coords if heatmap_coords.save
        end
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

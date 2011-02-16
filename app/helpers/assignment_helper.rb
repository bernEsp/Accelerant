module AssignmentHelper

  def size_helper(user)
    if user.participant
      size = [585, 465]
    else
      size = [440, 310]
    end
  end

  def show_heatmap(discussion)
    if discussion.has_heatmap 
      heatmap = Heatmap.find(:last, :conditions => {:discussion_id => discussion.id , :user_id => self.current_user.id})
      unless heatmap && self.current_user.participant
        true
      else
        false
      end
    end
  end

  def heatmap_screenshot(discussion)
   heatmap = discussion.heatmaps.find(:last, :conditions => {:user_id => self.current_user.id})
   if heatmap
      heatmap.image_result
   else
      ""
   end
  end
    #Heatmap.create_tmp_image(discussion.id, self.current_user.id)
end

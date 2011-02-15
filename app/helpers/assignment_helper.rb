module AssignmentHelper

  def size_helper(user)
    if user.participant
      size = [585, 465]
    else
      size = [440, 310]
    end
  end

  def show_heatmap(discussion)
    if @discussion.has_heatmap
      heatmap = Heatmap.find(:last, :conditions => {:discussion_id => @discussion.id , :user_id => self.current_user.id})
      unless heatmap 
        true
      end
    end
  end

end

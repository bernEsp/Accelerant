module RepliesHelper
  def render_reply(replies)
    output = "<div id='reply#{replies.id}' style='background-color:#cdd7de;margin:8px;padding:2px;'>"

    output = output + render_small_avatar(replies.user)
    output = output + "&nbsp;&nbsp;"
    output = output + simple_format(replies.content)
		if replies.media_file_name
      if replies.media_content_type =~ /image.*/
        #output = output + "<a href='#{replies.media.url}' class='MagicThumb' rel='buttons:hide' target='_blank'>"
        output = output + "<a href='#{replies.media.url}' target='_blank'>"
        output = output + image_tag(replies.media.url(:small), :style => 'margin-left:1px;')
        output = output + "</a>"
			else
        output = output + "<a href='#{replies.media.url}' target='_blank'>View attached file here.</a>"
        output = output + image_tag("download.png")
			end
		end
		output = output + " posted by "
    if replies.user.name == self.current_user.name
       output = output + "you "
		else
			output = output + replies.user.name + " "
		end
		output = output + time_ago_in_words(replies.created_at)
    output = output + " ago"
    unless @project.lock
      if (replies.user.id == self.current_user.id) || self.current_user.admin

        output = output + " | "
        output = output + link_to_remote("Delete",
					:confirm => "Are you sure you want to delete this?",
					:url => {:controller => 'plain', :action => 'drop_reply', :id => replies.id},
					:complete => "new Effect.Fade('reply#{replies.id}', { duration: 2 })",
					:update => "reply#{replies.id}")
      end
      if (self.current_user.admin || self.current_user.moderator)
        output = output + " | "
        output = output + link_to_remote("Probe",
					:url => {:controller => 'plain', :action => 'follow_up', :id => replies.id},
					:update => "reply#{replies.id}")
      end
    end
    if (self.current_user.admin || self.current_user.moderator || (self.current_user.id == replies.user_id) )
      @follows = FollowUps.find(:all, :conditions => {:reply_id => replies.id}, :order => "id ASC")
      @follows_last = FollowUps.find(:last, :conditions => {:reply_id => replies.id}, :order => "id ASC")
    else
      @follows = FollowUps.find(:all, :conditions => "1 = 0")
    end
    for follows in @follows
      output = output + render_probe(follows,replies)
    end
    output = output + "<br/><br/>"
    output = output + "</div> <!-- end reply -->"
    return output
  end

  def render_reply_standalone(replies)
    output = "<div id='reply#{replies.id}' style='background-color:#cdd7de;margin:8px;padding:2px;'>"

    output = output + render_small_avatar(replies.user)
    output = output + "&nbsp;&nbsp;"
    output = output + simple_format(replies.content)
		if replies.media_file_name
      if replies.media_content_type =~ /image.*/
        output = output + "<a href='#{replies.media.url}' target='_blank'>"
        output = output + image_tag(replies.media.url(:small), :style => 'margin-left:1px;')
        output = output + "</a>"
			else
        output = output + "<a href='#{replies.media.url}' target='_blank'>View attached file here.</a>"
        output = output + image_tag("download.png")
			end
		end
		output = output + " posted by "
    if replies.user.name == self.current_user.name
       output = output + "you "
		else
			output = output + replies.user.name + " "
		end
		output = output + time_ago_in_words(replies.created_at)
    output = output + " ago"

    output = output + "<br/><br/>"
    output = output + "</div> <!-- end reply -->"
    return output
  end
end

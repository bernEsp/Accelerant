module ProbesHelper

  def render_probe(probe,replies)
    probe_return = "<div class='probe' id='probe_id#{probe.id}'>"
    probe_return = probe_return + "<em>#{User.find(probe.user_id).name } followed up with: </em>"
    probe_return = probe_return + simple_format(probe.content)
    #probe_return = probe_return + simple_format(Remo.new(probe.content).to_html)
    if (self.current_user.admin || self.current_user.moderator)
      probe_return = probe_return + link_to_remote('Delete', :url => {:controller => 'plain', :action => 'delete_probe', :id => probe.id}, :update => "probe_id#{probe.id}")
    end
    probe_return = probe_return + "</div>"
    
    if (probe.id == @follows_last.id) && !@project.lock
      probe_return = probe_return + "<div id='probe_follow#{replies.id}'>"
      probe_return = probe_return + "<br/>"
      probe_return = probe_return + link_to_remote('Follow Up', :url => {:controller => 'plain', :action => 'follow_up_reply', :id => replies.id}, :update => "probe_follow#{replies.id}")
      probe_return = probe_return + "</div>"
    end
    
    return probe_return
  end
  
end

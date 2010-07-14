module AvatarHelper
  
  def render_avatar(user)
    if user.avatar.url == "" #No avatar
      unless user.participant? || !self.current_user.participant?
        return image_tag('gravatar-40.png')
      else
        return link_to image_tag('gravatar-40.png'), {:controller => 'users', :action => 'detail', :id => user.id}, {:target => "_blank" }
      end

    else #avatar
      unless user.participant? || !self.current_user.participant?
        return image_tag(user.avatar.url(:small))
      else
        return link_to image_tag(user.avatar.url(:small)), {:controller => 'users', :action => 'detail', :id => user.id}, {:target => "_blank" }
      end
    end
  end

  def render_small_avatar(user)
    if user.avatar.url == ""
      unless user.participant? || !self.current_user.participant?
        return image_tag('gravatar-20.png')
      else
        return link_to image_tag('gravatar-20.png'), {:controller => 'users', :action => 'detail', :id => user.id}, {:target => "_blank" }
      end
    else
      unless user.participant? || !self.current_user.participant?
        return image_tag(user.avatar.url(:smaller))
      else
        return link_to image_tag(user.avatar.url(:smaller)), {:controller => 'users', :action => 'detail', :id => user.id}, {:target => "_blank" }
      end
    end
  end


end

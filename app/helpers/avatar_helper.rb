module AvatarHelper
  
  def render_avatar(user)
    if user.avatar.url == ""
      if self.current_user.participant?
        image_tag('gravatar-40.png')
      else
        return link_to image_tag('gravatar-40.png'), :controller => 'users', :action => 'detail', :id => user.id
      end
    else
      if self.current_user.participant?
        return image_tag(user.avatar.url(:small))
      else
        return link_to image_tag(user.avatar.url(:small)), :controller => 'users', :action => 'detail', :id => user.id
      end
    end
  end


end

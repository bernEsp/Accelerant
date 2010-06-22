# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def page_title(title, options = {})
    content_tag('h1', title, {:class => 'lower'}.merge(options)) if title
    
  end
  
end

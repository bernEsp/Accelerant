module GroupablesHelper

  def perception_map(discussions)
    html = ""
    @usergroupables = Usergroupables.find_all_by_groupable(discussions.groupable, :conditions => {:user => self.current_user.id})
    for usergroupable in @usergroupables

      div_for usergroupable, :style => 'text-align:center;display:block;float:left;margin:5px;' do

        unless Groupableitems.find(usergroupable.groupableitem).image.url == ""
          html << "#{image_tag Groupableitems.find(usergroupable.groupableitem).image.url(:size50), :style => 'vertical-align:middle;'}"
          html << "<br/>"
        end
        Groupableitems.find(usergroupable.groupableitem).description

      end
      html << "#{draggable_element("usergroupables_#{usergroupable.id}", :revert => false)}"
    end

    html << "<div style='clear:left;'></div>"

    i = 0

    @groupabletargets = Groupabletargets.find_all_by_groupable(discussions.groupable, :order => "id DESC")
    @groupabletargets.each do |groupabletarget|

      i = i +1
      if i==3
        html << "<div style='clear:both'></div>"
      end

      div_for groupabletarget, :class => "perceptiontargets" do
        html << "#{groupabletarget.description}"
      end

      html << "#{drop_receiving_element("groupabletargets_#{groupabletarget.id}",
      :hoverclass => 'hover',
      :url =>{ :controller => "groupableitems",
      :action => "group",
      :target => groupabletarget.id,
      :user => self.current_user.id })}"

    end
  html
  end
end
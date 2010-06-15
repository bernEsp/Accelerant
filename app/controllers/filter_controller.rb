class FilterController < ApplicationController

  layout 'filter'

  def filter_set

  
  1.upto(10) { |n| 
      params["field_#{n}"].each_key do |field_name|
        field_name.each_with_index do |name,index|
          if params["field_#{n}"][name] == "1"
            #puts "#{field_name} from field_#{n}"
            cookies[field_name] = { :value => "field_#{n}", :expires => Time.now + 3600}
            cookies[:filter] = {:value => "yes", :expires => Time.now + 3600}
          end
        end
      end
    }
    render :text => "Filter set"
  end

  def filter_clear
    cookies.to_hash.each_pair do |k, v|
      if cookies[k.to_sym].split('_')[0] == "field"
        cookies.delete(k.to_sym)
      end
    end
    cookies.delete(:filter)
    render :text => "Filter cleared"
  end
  
end

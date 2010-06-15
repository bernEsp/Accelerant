class FilterController < ApplicationController

  layout 'filter'

def filter_set
  1.upto(10) { |n| 
      params["field_#{n}"].each_key do |field_name|
        field_name.each_with_index do |name,index|
          if params["field_#{n}"][name] == "1"
            puts "#{field_name} from field_#{n}"
          end
        end
      end
    }
    render :text => "Filter set"
  end

  
end

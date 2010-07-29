class FilterController < ApplicationController

  layout 'filter'

  if ENV['RAILS_ENV'] == 'production'
    #ssl_required :filter_set, :filter_clear, :index
  end

  def filter_set
  i = Integer(params[:filter][:num_params])
  sql = ""
  #puts i
  1.upto(i) { |n|
      params["field_#{n}"].each_key do |field_name|
        field_name.each_with_index do |name,index|
          if params["field_#{n}"][name] == "1"
            #puts "#{field_name} from field_#{n}"
            cookies[field_name] = { :value => "field_#{n}", :expires => Time.now + 3600}
            cookies[:filter] = {:value => "yes", :expires => Time.now + 3600}
            sql = sql + " field_#{n} = '#{field_name}' AND"
          else
            cookies.delete(field_name)
          end
        end
      end
    }
    sql.chop!.chop!.chop!
    cookies[:sql] = {:value => sql, :expires => Time.now + 3600}
    puts "cookie:"
    puts cookies[:sql]
    #render :update do |page|
      #page << "document.getElementById('responses').innerHTML = 'You need to reload this page';"
    #end

    #render :partial => 'plain/comment_puker'
    #render :text => "Filter Set"
    render :update do |page|
      page << "window.location.reload(false)"
    end
  end

  def filter_clear
    cookies.to_hash.each_pair do |k, v|
      if cookies[k.to_sym].split('_')[0] == "field"
        cookies.delete(k.to_sym)
      end
    end
    cookies.delete(:filter)
    #render :text => "Filter cleared"

    render :update do |page|
      page << "window.location.reload(false)"
    end
  end
  
end

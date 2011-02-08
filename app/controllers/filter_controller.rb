class FilterController < ApplicationController

  layout 'filter'

  if ENV['RAILS_ENV'] == 'production'
    ssl_required :filter_set, :filter_set_new, :filter_clear, :index
  end

  def filter_set
  i = Integer(params[:filter][:num_params])
  sql = " "
  previousen = ""
  orflag = false
  #puts i
  #1.upto(10) max
  1.upto(i) { |n|
      params["field_#{n}"].each_key do |field_name|
        field_name.each_with_index do |name,index|
          
          if params["field_#{n}"][name] == "1" #is it checked off?
            #puts "#{field_name} from field_#{n}"
            cookies[field_name] = { :value => "field_#{n}", :expires => Time.now + 3600}
            cookies[:filter] = {:value => "yes", :expires => Time.now + 3600}

            if (params["field_#{n}"] == previousen) &&  previousen != ""
              joiner = "OR"
              sql = sql.sub("openparen#{n}", '(')
              orflag = true

            else #this is an AND
              if orflag
                #joiner = ") "
                joiner = " "
                orflag = false
              else
                joiner = " "
              end
              joiner = joiner + "AND openparen#{n} "
            end

            #if this is the first grouping we start with a parenthesis
            if previousen == ""
              joiner = "( "
            end

            sql = sql + "#{joiner} field_#{n} = '#{field_name}' closeparen#{n} "
            if !orflag && ((params["field_#{n}"] != previousen) && (previousen != ""))
              sql = sql.sub("openparen#{n}", '(')
              sql = sql.sub("closeparen#{n}", "tempclose#{n}") ############ this is the problem line
            else
              sql = sql.sub("closeparen#{n}", '')
              sql = sql.sub("tempclose#{n}", '') ############ this is the problem line
            end
            previousen = params["field_#{n}"]
            #sql = sql + ") "
          else
            cookies.delete(field_name)
          end
          #if orflag
            #sql = sql + ")"
            #orflag = false

          #end
        end
      end
    }
    #sql.chop!.chop!.chop!
    sql = sql + ")"
    cookies[:sql] = {:value => sql, :expires => Time.now + 3600}
    #puts "cookie:"
    #puts cookies[:sql]
    puts "here it is!"
    puts sql


    #render :partial => 'plain/comment_puker'
    #render :text => "Filter Set"
    render :update do |page|
      page << "window.location.reload(false)"
    end
  end

  def filter_set_new
    cookies.to_hash.each_pair do |k, v|
      if cookies[k.to_sym].split('_')[0] == "field"
        cookies.delete(k.to_sym)
      end
    end
    i = Integer(params[:filter][:num_params])  #maximum of 10

    #first we build our arrays
    field_array = Array.new
    1.upto(i) { |n|
            field_array[n] = Array.new
            params["field_#{n}"].each_key do |field_name|
              field_name.each_with_index do |name,index|
                if params["field_#{n}"][name] == "1" #is it checked off?
                  cookies[field_name] = { :value => "field_#{n}", :expires => Time.now + 3600}
                  cookies[:filter] = {:value => "yes", :expires => Time.now + 3600}
                  field_array[n] << name
                else
                  #cookies.delete(field_name)
                end
                #puts "array dump:"
                #puts field_array[n]
                #puts field_array[n].length
              end
            end
    }

    #arrays built

    #build the sql by cycling back thru the arrays
    sql = ""
    1.upto(i) { |n|
      if field_array[n].length > 0
        if field_array[n].length == 1
          #this is a single category element so we just wrap it in parenthesis
          if sql == ""
            #if it's the very first condition we don't want the AND
            sql = sql + "( field_#{n} = '#{field_array[n]}' )"
          else
            sql = sql + " AND ( field_#{n} = '#{field_array[n]}' )"
          end
        else 
          #this will be an OR block
          if sql == ""
            #if it's the very first condition we don't want the AND
            sql = sql + "("
          else
            sql = sql + " AND ("
          end
          0.upto(field_array[n].length-1) { |z|
            #cycle thru the array and build all the comparisons
            if z == 0
              #if it's the first element we don't want the OR
              sql = sql + " field_#{n} = '#{field_array[n][z]}' "
            else
              sql = sql + " OR field_#{n} = '#{field_array[n][z]}' "
            end
          }
          #...and close the OR statement with closing parenthesis
          sql = sql + ") "
        end
      end
    }
    #puts sql
    cookies[:sql] = {:value => sql, :expires => Time.now + 3600}
    puts "cookies set"
    render :update do |page|
      page << "window.location.reload(false)"
    end

    puts "all done"
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

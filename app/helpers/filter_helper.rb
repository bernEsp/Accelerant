module FilterHelper

  def filter_results(replies)
    if cookies[:filter] == "yes"
      cookies.to_hash.each_pair do |k, v|
          if cookies[k.to_sym].split('_')[0] == "field"
            if replies.user.send(cookies[k.to_sym])
              displayflag = true
            else
              displayflag = false
            end
          end
      end
    end
    puts "sqlstring here:"
    puts sqlstring
  end
end

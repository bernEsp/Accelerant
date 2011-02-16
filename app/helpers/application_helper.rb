# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def page_title(title, options = {})
    content_tag('h1', title, {:class => 'lower'}.merge(options)) if title
    
  end

  def client_browser_name
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    if user_agent =~ /msie/i
      "Internet Explorer"
    elsif user_agent =~ /konqueror/i
      "Konqueror"
    elsif user_agent =~ /gecko/i
      "Mozilla"
    elsif user_agent =~ /opera/i
      "Opera"
    elsif user_agent =~ /applewebkit/i
      "Safari"
    else
      "Unknown"
    end
  end

def getBrowser(bt)
    rs=false
    ua=request.env['HTTP_USER_AGENT'].downcase
    isOpera = ua.index('opera') ? true : false
    isSafari = (ua =~ /webkit|khtml/) ? true : false
    isSafari3 = (ua.index('webkit/5')) ? true : false
    isGecko = (!isSafari and ua.index('gecko')) ? true : false
    isGecko3 = (!isSafari and ua.index('rv:1.9')) ? true : false
    isIE = (!isOpera and ua.index('msie')) ? true : false
    isIE7 = (!isOpera and ua.index('msie 7')) ? true : false
    case bt
      when 0  #isKonqueror
        if ua.index('konqueror') then rs=true end
      when 1  #isOpera
        rs=isOpera
      when 2  #isSafari
        rs=isSafari
      when 3  #isSafari2
        rs=isSafari && !isSafari3
      when 4  #isSafari3
        rs=isSafari3
      when 5  #isIE
        rs=isIE
      when 6  #isIE6
        rs=isIE && !isIE7
      when 7  #isIE7
        rs=isIE7
      when 8  #isGecko
        rs=isGecko
      when 9  #isGecko2
        rs=isGecko && !isGecko3
      when 10 #isGecko3
        rs=isGecko3
      when 11 #isWindows
        if ua.index('windows') or ua.index('win32') then rs=true end
      when 12 #isMac
        if ua.index('macintosh') or ua.index('mac os x') then rs=true end
      when 13 #isAir
        if ua.index('adobeair') then rs=true end
      when 14 #isLinux
        if ua.index('linux') then rs=true end
      when 15 #isSecure
        s = request.env['SERVER_PROTOCOL'].downcase
        if s.index('https') then rs=true end
    end
    rs
end

def safari_check
    ua=request.env['HTTP_USER_AGENT'].downcase
    isOpera = ua.index('opera') ? true : false
    isSafari = (ua =~ /webkit|khtml/) ? true : false
    isSafari3 = (ua.index('webkit/5')) ? true : false
    isGecko = (!isSafari and ua.index('gecko')) ? true : false
    isGecko3 = (!isSafari and ua.index('rv:1.9')) ? true : false
    isIE = (!isOpera and ua.index('msie')) ? true : false
    isIE7 = (!isOpera and ua.index('msie 7')) ? true : false

    if isSafari || isSafari3
      "Safari"
    else
      "Other"
    end
end
  
end

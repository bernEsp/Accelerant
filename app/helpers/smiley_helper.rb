module SmileyHelper

  #http://harrikauhanen.posterous.com/

  
  SMILEYS = {
  ':)' => 'smile',
  ':-)' => 'smile',
  '=]' => 'smile',
  '=)' => 'smile',
  ';)' => 'wink',
  ';]' => 'wink',
  ';-)' => 'wink'
} # and the rest of the smilies...

def smiley(text)
  SMILEYS.each do |smiley, smiley_class|
    text.gsub!(smiley, "<span class='smiley #{smiley_class}'><span class='smiley-as-text'>#{smiley}</span>&nbsp;</span>")
  end
  return text
end
end
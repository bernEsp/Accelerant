rEmo - ruby emoticons parser
============================

rEmo transforms ASCII-emoticons to HTML.

## Install

  gem install remo

## Usage

First you need to copy the themes in your project, for example, in irb:

  Remo.copy!('public/images/emoticons')
  
It will copy the themes in `pwd`/public/images/emoticons/ ...

And, parse :

  Remo.new(string).to_html

See the [rdoc][2] for advanced usage.

## Themes

Two themes are bundled into rEmo : [simplesmileys][3] and [skype][4]. You can preview the themes on the [homepage][1].

A theme is a YAML file of regexps->image name. You can create one, but it's not recommended for your mental health (regexps sucks!).

[1]: http://webs.github.com/remo/
[2]: http://rdoc.info/projects/webs/remo/
[3]: http://simplesmileys.org/
[4]: http://www.skype.com/intl/en/allfeatures/emoticons/
$:.unshift File.dirname(__FILE__)
require 'yaml'
require 'fileutils'
class Remo
  attr_reader :options, :emoticons, :string
  
  # Initialize rEmo.
  #
  # +string+: the string to rEmotize!
  #
  # +options+: hash of options:
  #  - theme: the theme to use. Default is 'simplesmileys'
  #  - images_path: the path for the images. Default is '/images/emoticons/'
  #  - extras: Add more emoticons 'on the fly'. Hash of regexp => image. Default is an empty hash.
  def initialize(string, options={})
    options[:theme] ||= "simplesmileys"
    #options[:theme] ||= "skype"
    options[:images_path] ||= "/images/emoticons/"
    options[:extras] ||= {}
    @string, @options = string, options
    load_theme
  end
  
  # Converts all emoticons in +string+ to HTML-image tags.
  def to_html
    @emoticons.each do |regexp, image|
      @string.gsub!(Regexp.new("(^|\s)(#{regexp})(\s|$)"), " <img src='#{@options[:images_path]}#{@options[:theme]}/#{image}' title='#{@string}' /> ")
    end
    @options[:extras].each do |regexp, image|
      @string.gsub!(Regexp.new("(^|\s)(#{regexp})(\s|$)"), " <img src='#{@options[:images_path]}extras/#{image}'/> ")
    end
    @string
  end
  
  # Converts all emoticons in +string+ to Textile-image tags.
  def to_textile
    @emoticons.each do |regexp, image|
      @string.gsub!(Regexp.new("(^|\s)(#{regexp})(\s|$)"), " !#{@options[:images_path]}#{@options[:theme]}/#{image}! ")
    end
    @options[:extras].each do |regexp, image|
      @string.gsub!(Regexp.new("(^|\s)(#{regexp})(\s|$)"), " !#{@options[:images_path]}extras/#{image}! ")
    end
    @string
  end
  
  # Copy the themes to +directory+ (default is public/images/emoticons)
  def self.copy!(directory='public/images/emoticons/')
    dir = "#{Dir.pwd}/#{directory}"
    FileUtils.cp_r "#{::File.expand_path(::File.dirname(__FILE__))}/themes/", dir
  end
  
  private
  def load_theme
    file = "#{::File.expand_path(::File.dirname(__FILE__))}/themes/#{@options[:theme]}.yml"
    if File.exists?(file)
      @emoticons = YAML.load(File.read(file))
    else
      raise "Theme '#{@options[:theme]}' not found!"
    end
  end
end
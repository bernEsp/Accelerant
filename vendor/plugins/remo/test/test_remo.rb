require 'helper'

class TestRemo < Test::Unit::TestCase
  context 'new' do
    should 'have default options' do
      assert_equal Remo.new("hello").options, {:theme => 'simplesmileys', :images_path => '/images/emoticons/', :extras => {}}
    end
  
    should 'load the theme' do
      assert_equal Remo.new("hello").emoticons, YAML.load(File.read("#{::File.expand_path(::File.dirname(__FILE__))}/../lib/themes/simplesmileys.yml"))
    end
  end
  
  context 'to_html' do
    should "transform ascii emoticons" do
      assert_equal Remo.new("This test sucks a little bit :) ...").to_html, "This test sucks a little bit <img src='/images/emoticons/simplesmileys/Smiling.png'/> ..."
    end
  
    should "transform ascii emoticons with another theme" do
      assert_equal Remo.new("This test sucks a little bit :) ...", {:theme=>'skype'}).to_html, "This test sucks a little bit <img src='/images/emoticons/skype/0100-smile.png'/> ..."
    end
  
    should "change the smiley path if options[:images_path] is specified" do
      assert_equal Remo.new("This test sucks a little bit :) ...", {:images_path=>'/hello/'}).to_html, "This test sucks a little bit <img src='/hello/simplesmileys/Smiling.png'/> ..."
    end
  
    should "transform ascii extras emoticons" do
      assert_equal Remo.new("This test sucks a little bit :helloworld: ...", {:extras=>{"(:helloworld:)"=>'helloworld.png'}}).to_html, "This test sucks a little bit <img src='/images/emoticons/extras/helloworld.png'/> ..."
    end
  end

  context 'to_textile' do
    should "transform ascii emoticons" do
      assert_equal Remo.new("This test sucks a little bit :) ...").to_textile, "This test sucks a little bit !/images/emoticons/simplesmileys/Smiling.png! ..."
    end
  
    should "transform ascii emoticons with another theme" do
      assert_equal Remo.new("This test sucks a little bit :) ...", {:theme=>'skype'}).to_textile, "This test sucks a little bit !/images/emoticons/skype/0100-smile.png! ..."
    end
  
    should "change the smiley path if options[:images_path] is specified" do
      assert_equal Remo.new("This test sucks a little bit :) ...", {:images_path=>'/hello/'}).to_textile, "This test sucks a little bit !/hello/simplesmileys/Smiling.png! ..."
    end
  
    should "transform ascii extras emoticons" do
      assert_equal Remo.new("This test sucks a little bit :helloworld: ...", {:extras=>{"(:helloworld:)"=>'helloworld.png'}}).to_textile, "This test sucks a little bit !/images/emoticons/extras/helloworld.png! ..."
    end
  end
  
  context 'copy!' do
    should 'copy in the right directory' do
      FileUtils.mkdir 'tmp'
      Remo.copy!('tmp/emoticons')
      assert_equal Dir.entries("#{::File.expand_path(::File.dirname(__FILE__))}/../lib/themes/"), Dir.entries("tmp/emoticons/")
      FileUtils.rm_r 'tmp'
    end
  end
end

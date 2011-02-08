require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'comma'


class Book
  attr_accessor :name, :description, :isbn
  
  def initialize(name, description, isbn)
    @name, @description, @isbn = name, description, isbn
  end
  
  comma do
    name 'Title'
    description
    
    isbn :number_10 => 'ISBN-10', :number_13 => 'ISBN-13', :authority => :issuer
  end
  
end

class Isbn
  attr_accessor :number_10, :number_13
  
  def initialize(isbn_10, isbn_13)
    @number_10, @number_13 = isbn_10, isbn_13
  end
  
  def authority; 'ISBN'; end
end

class Discussion < ActiveRecord::Base
  belongs_to :project
  
  #named_scope :is_last, :conditions => {:is_published => true}
end

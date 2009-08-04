class Discussion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  #named_scope :is_last, :conditions => {:is_published => true}
end

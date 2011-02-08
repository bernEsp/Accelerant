class FollowUps < ActiveRecord::Base
  belongs_to :reply

  named_scope :was_read, :conditions => {:read => true}
  named_scope :not_old, :conditions => ['read IS NOT NULL']
  named_scope :unread, :conditions => {:read => false}

end

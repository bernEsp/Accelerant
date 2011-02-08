class Usersortables < ActiveRecord::Base
  named_scope :by_participant, :conditions => {:participant => true}
end

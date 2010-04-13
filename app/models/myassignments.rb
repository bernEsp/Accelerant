class MyAssignments < ActiveRecord::Base
named_scope :my_assignments, :conditions => { :user_id => self.current_user.id}
end

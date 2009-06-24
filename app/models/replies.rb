class Replies < ActiveRecord::Base
  belongs_to :comments
  belongs_to :user
end

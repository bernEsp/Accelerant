class Heatmap < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  belongs_to :comment

end

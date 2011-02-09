class Heatmap < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  has_many   :heatmap_coords
end

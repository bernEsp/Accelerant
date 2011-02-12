class Heatmap < ActiveRecord::Base

  belongs_to :user
  belongs_to :discussion
  belongs_to :comment
  has_many :heatmap_coords
end

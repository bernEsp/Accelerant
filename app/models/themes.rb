class Themes < ActiveRecord::Base

  has_attached_file :logo,
  :whiny => false,
  :whiny_thumbnails => false,
  :styles => {
  :size300 => "300x300>",
  :size200 => "200x200>",
  :size100 => "100x100>",
  :size75 => "75x75>",
  :size50 => "50x50>",
  :size30 => "30x30>",
  :size20 => "20x20>" }


end

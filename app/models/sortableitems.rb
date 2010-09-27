class Sortableitems < ActiveRecord::Base
acts_as_list
has_attached_file :image,
  :whiny => false,
  :whiny_thumbnails => false,
  :styles => {
  :size600 => "600x600>",
  :size500 => "500x500>",
  :size400 => "400x400>",
  :size300 => "300x300>",
  :size200 => "200x200>",
  :size100 => "100x100>",
  :size80 => "80x80>",
  :size50 => "50x50>",
  :size30 => "30x30>",
  :size20 => "20x20>"
  }

  
end

class Themes < ActiveRecord::Base

  validates_presence_of     :name
  validates_length_of       :name,    :within => 4..20
  validates_uniqueness_of   :name
  validates_format_of       :name, :with => /\A\w+\z/

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

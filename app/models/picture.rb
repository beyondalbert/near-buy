class Picture < ActiveRecord::Base
  has_attached_file :file, :styles => { :medium => "450x450>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  belongs_to :imageable, polymorphic: true
end
